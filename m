Return-Path: <linux-kernel+bounces-686690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FACAD9A8D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 08:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B2E3B8D9D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 06:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD411DEFE1;
	Sat, 14 Jun 2025 06:50:54 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0921EDA02;
	Sat, 14 Jun 2025 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749883854; cv=none; b=kvm4qqYWf70AlVgSOPDbR1riQwTfrM7ebAMAS38RjpJ6Q0EcHvGfX4b5z4xOCE/NvNWCqHeEgq1RLjpR6y6ZVr19FUIVIjJRlJ3MDqYfoYCGVKPRb5291rb87honVtq5BsPnrs5mD7kc5Ics3zXoLDsnYpdGsBhRKGlE2l14Wvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749883854; c=relaxed/simple;
	bh=jgfZugwghp2JlIjkP+brwrtVHOqmSVyXqYoNE696IOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEM2agCzX5fPIuUo693508j70JjrM/MCEobGQAb5Lv0kug6wRxJJKlMgaSOFay25zNydXsyVpNRWuAkE1XKFMneRnkFRYxG3H3w5PWum14s3rPMz7jO3GRuwmT8xSZDiCOSrqDlLNJMcDd6z+Ve598oB90uBeOzFURNOdJj1ogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bK6Cy21Trz9syj;
	Sat, 14 Jun 2025 08:43:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7-nfL4VEBL3; Sat, 14 Jun 2025 08:43:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bK6Cw6f1Lz9syQ;
	Sat, 14 Jun 2025 08:43:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DF9808B77C;
	Sat, 14 Jun 2025 08:43:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id IRFdjwNIQ8pl; Sat, 14 Jun 2025 08:43:24 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 74BCB8B77B;
	Sat, 14 Jun 2025 08:43:24 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v3 4/4] ALSA: pcm: Convert snd_pcm_sync_ptr() to user_access_begin/user_access_end()
Date: Sat, 14 Jun 2025 08:43:17 +0200
Message-ID: <6ce6bc4da498ea7ea2be5f279b374370b1613b13.1749883041.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1749883041.git.christophe.leroy@csgroup.eu>
References: <cover.1749883041.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749883394; l=3615; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=jgfZugwghp2JlIjkP+brwrtVHOqmSVyXqYoNE696IOg=; b=BrHy+Chki7RelxAKtji7NaCi7jwbSjSvpGKGmfSim8KyqAAv7OIf2MPyP/hkx4k7Se9m7a3CD z4DXP83zRYVDpUed2aN7gwZfe63dBK9DNNOyybLBgi3u5uqotuftqqU
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Now that snd_pcm_sync_ptr_get_user() and snd_pcm_sync_ptr_put_user()
are converted to user_access_begin/user_access_end(),
snd_pcm_sync_ptr_get_user() is more efficient than a raw get_user()
followed by a copy_from_user(). And because copy_{to/from}_user() are
generic functions focussed on transfer of big data blocks to/from user,
snd_pcm_sync_ptr_put_user() is also more efficient for small amont of
data.

So use snd_pcm_sync_ptr_get_user() and snd_pcm_sync_ptr_put_user() in
snd_pcm_sync_ptr() too.

snd_pcm_ioctl_sync_ptr_buggy() is left as it is because the conversion
wouldn't be straigh-forward due to the workaround it provides.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 sound/core/pcm_native.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index b7339c9ebb1f..1eab940fa2e5 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3096,45 +3096,43 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 			    struct snd_pcm_sync_ptr __user *_sync_ptr)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_pcm_sync_ptr sync_ptr;
 	volatile struct snd_pcm_mmap_status *status;
 	volatile struct snd_pcm_mmap_control *control;
+	u32 sflags;
+	struct snd_pcm_mmap_control scontrol;
+	struct snd_pcm_mmap_status sstatus;
 	int err;
 
-	memset(&sync_ptr, 0, sizeof(sync_ptr));
-	if (get_user(sync_ptr.flags, (unsigned __user *)&(_sync_ptr->flags)))
+	if (snd_pcm_sync_ptr_get_user(sflags, scontrol, _sync_ptr))
 		return -EFAULT;
-	if (copy_from_user(&sync_ptr.c.control, &(_sync_ptr->c.control), sizeof(struct snd_pcm_mmap_control)))
-		return -EFAULT;	
 	status = runtime->status;
 	control = runtime->control;
-	if (sync_ptr.flags & SNDRV_PCM_SYNC_PTR_HWSYNC) {
+	if (sflags & SNDRV_PCM_SYNC_PTR_HWSYNC) {
 		err = snd_pcm_hwsync(substream);
 		if (err < 0)
 			return err;
 	}
 	scoped_guard(pcm_stream_lock_irq, substream) {
-		if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_APPL)) {
-			err = pcm_lib_apply_appl_ptr(substream,
-						     sync_ptr.c.control.appl_ptr);
+		if (!(sflags & SNDRV_PCM_SYNC_PTR_APPL)) {
+			err = pcm_lib_apply_appl_ptr(substream, scontrol.appl_ptr);
 			if (err < 0)
 				return err;
 		} else {
-			sync_ptr.c.control.appl_ptr = control->appl_ptr;
+			scontrol.appl_ptr = control->appl_ptr;
 		}
-		if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
-			control->avail_min = sync_ptr.c.control.avail_min;
+		if (!(sflags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
+			control->avail_min = scontrol.avail_min;
 		else
-			sync_ptr.c.control.avail_min = control->avail_min;
-		sync_ptr.s.status.state = status->state;
-		sync_ptr.s.status.hw_ptr = status->hw_ptr;
-		sync_ptr.s.status.tstamp = status->tstamp;
-		sync_ptr.s.status.suspended_state = status->suspended_state;
-		sync_ptr.s.status.audio_tstamp = status->audio_tstamp;
+			scontrol.avail_min = control->avail_min;
+		sstatus.state = status->state;
+		sstatus.hw_ptr = status->hw_ptr;
+		sstatus.tstamp = status->tstamp;
+		sstatus.suspended_state = status->suspended_state;
+		sstatus.audio_tstamp = status->audio_tstamp;
 	}
-	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_APPL))
+	if (!(sflags & SNDRV_PCM_SYNC_PTR_APPL))
 		snd_pcm_dma_buffer_sync(substream, SNDRV_DMA_SYNC_DEVICE);
-	if (copy_to_user(_sync_ptr, &sync_ptr, sizeof(sync_ptr)))
+	if (snd_pcm_sync_ptr_put_user(sstatus, scontrol, _sync_ptr))
 		return -EFAULT;
 	return 0;
 }
-- 
2.47.0


