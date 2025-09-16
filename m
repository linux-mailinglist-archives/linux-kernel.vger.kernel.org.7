Return-Path: <linux-kernel+bounces-819237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B645B59D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D311E3B4884
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8393527E074;
	Tue, 16 Sep 2025 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1EE+nP5L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7vC6bWcK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hISESrwM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SsYRJ+1V"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD4328567
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038963; cv=none; b=P86T2Ctsq5j8yjwXv2MiQXO6JpdWm63O3ByP8L4FOCUSwyG89cuXIaU1h239/okhVgPGoqUX44ZZcFhXdKiJrvFV2L7XtzeYORQbwIxajaYQdz+VsC+bGND0OSSnflovPiOQ7LJwaz8XNH5lGHN2GOb6PhnBKTl6uVGgtyvsMOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038963; c=relaxed/simple;
	bh=gHBFPGLxpgeIbpqz53lBnp+GFhA6FFof1/8vmOqOGoE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFaLIdHl6zlpoGHE0IVXLpMKSMhPzDSUkLe46i5vF9I2YgxJP97ZTtjPC5FZRcmQXIlPq3GRDTWewV39Rk/YHy+mqB36F5mjhlRwm2Siwh3a2scgB7QsfBS77iImUTCneY1WT5spG16LwNyGMH3RJck9TbUrXHiQn3BejswxhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1EE+nP5L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7vC6bWcK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hISESrwM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SsYRJ+1V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAB2F1F453;
	Tue, 16 Sep 2025 16:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758038959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sk5AEI/paeTqJ+QNDnjHg/KvAsKlZn9pZI9pJzQwMJ0=;
	b=1EE+nP5LkZNQAD1UiiG13D4lO1RGbKhrjLlO2fhVPILTDBJeMfs5+tjg+VxgmU+HfhYV13
	bs4TGizkhW1fGuTCUN7YtE55hbG66vO2b1IP3HFtXef8X8ICQGIakJcR1RcZo8KPNLBURg
	hnopb4muD5oABBxfDR3C/RKyuTs0m0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758038959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sk5AEI/paeTqJ+QNDnjHg/KvAsKlZn9pZI9pJzQwMJ0=;
	b=7vC6bWcKz1O2YREeyLf4QpftmnlLqeaPZ4plTqGvbPxdmbNNBXH3dqRRFWsXQ9s8s4jx/e
	lTK+9LEQOu6e07Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hISESrwM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SsYRJ+1V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758038958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sk5AEI/paeTqJ+QNDnjHg/KvAsKlZn9pZI9pJzQwMJ0=;
	b=hISESrwM1LjUKFjEDprbKKbLOW4F3yNktMqhMR6RqIb8igdiCyTLXh3KohubKC05AjCXyA
	q8EptqWsQfigsBmjAi4PlaSKHmk2aR3Dew3ZhdVmkngeuRcG+zcGTDAz1pKdlfXidJye63
	PlkNLEtnlQ3/n7VUXfFLSGQqv2I7Aos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758038958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sk5AEI/paeTqJ+QNDnjHg/KvAsKlZn9pZI9pJzQwMJ0=;
	b=SsYRJ+1VYrIEeso//o0izaLeJGA/0iyU3ENs4m9KHZv4KYXO8r68EH6KWsKVQpsSdv68EH
	EQZqtoHXwR8FwBCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 873BF13A63;
	Tue, 16 Sep 2025 16:09:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TgeOH66LyWhhSwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 16 Sep 2025 16:09:18 +0000
Date: Tue, 16 Sep 2025 18:09:18 +0200
Message-ID: <87o6raxtu9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Luca Weiss" <luca.weiss@fairphone.com>
Cc: "Arnd Bergmann" <arnd@arndb.de>,
	"Takashi Iwai" <tiwai@suse.de>,
	"Arnd Bergmann" <arnd@kernel.org>,
	"Mark Brown" <broonie@kernel.org>,
	"Wesley Cheng" <quic_wcheng@quicinc.com>,
	"Jaroslav Kysela"
 <perex@perex.cz>,
	"Takashi Iwai" <tiwai@suse.com>,
	"Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,
	"Dan Carpenter" <dan.carpenter@linaro.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ALSA: qc_audio_offload: try to reduce address space confusion
In-Reply-To: <DCU39JVDVFAG.2EOCQ37KAS3N0@fairphone.com>
References: <20250513123442.159936-1-arnd@kernel.org>
	<20250513123442.159936-4-arnd@kernel.org>
	<DBR2363A95M1.L9XBNC003490@fairphone.com>
	<87v7n72pg0.wl-tiwai@suse.de>
	<DBR3FZGY4QS1.BX6M1PZS5RH4@fairphone.com>
	<87ms8j2on6.wl-tiwai@suse.de>
	<DCKUCB8A1JCV.1GK0TW2YMXNZP@fairphone.com>
	<87bjnpqe45.wl-tiwai@suse.de>
	<a2a6843f-7e03-4b7e-b5fc-415ac9fc6621@app.fastmail.com>
	<DCU39JVDVFAG.2EOCQ37KAS3N0@fairphone.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EAB2F1F453
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.51

On Tue, 16 Sep 2025 10:41:01 +0200,
Luca Weiss wrote:
> 
> Hi Arnd,
> 
> On Fri Sep 5, 2025 at 4:54 PM CEST, Arnd Bergmann wrote:
> > On Fri, Sep 5, 2025, at 14:26, Takashi Iwai wrote:
> >> On Fri, 05 Sep 2025 13:47:28 +0200,
> >
> >> @@ -1051,18 +1050,13 @@ static int uaudio_transfer_buffer_setup(struct 
> >> snd_usb_substream *subs,
> >>  	if (!xfer_buf)
> >>  		return -ENOMEM;
> >> 
> >> -	/* Remapping is not possible if xfer_buf is outside of linear map */
> >> -	xfer_buf_pa = virt_to_phys(xfer_buf);
> >> -	if (WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))) {
> >> -		ret = -ENXIO;
> >> -		goto unmap_sync;
> >> -	}
> >>  	dma_get_sgtable(subs->dev->bus->sysdev, &xfer_buf_sgt, xfer_buf,
> >>  			xfer_buf_dma, len);
> >> 
> >>  	/* map the physical buffer into sysdev as well */
> >> +	/* note: 0 is passed to pa argument as we use sgt */
> >>  	xfer_buf_dma_sysdev = uaudio_iommu_map(MEM_XFER_BUF, dma_coherent,
> >> -					       xfer_buf_pa, len, &xfer_buf_sgt);
> >> +					       0, len, &xfer_buf_sgt);
> >>  	if (!xfer_buf_dma_sysdev) {
> >>  		ret = -ENOMEM;
> >>  		goto unmap_sync;
> >
> >
> > Makes sense. I had to rework the code a little more to actually
> > understand how it fits together, for reference the below version
> > (I don't expect it to build cleanly) would split up
> > uaudio_iommu_map() into one function that takes a physical
> > address and another function that takes an sg table.
> 
> Are you planning to post this as a proper patch? It's a bit late in the
> 6.17 cycle already but good to still get this fixed for final release.
> 
> Or revert the original commit that broke it for now.
> 
> I couldn't really test your patch since there's a couple of compile
> errors where I wasn't sure how to resolve them correctly.

Could you check the patch below, then?  At least it compiles without
errors.


Takashi

--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -538,38 +538,33 @@ static void uaudio_iommu_unmap(enum mem_type mtype, unsigned long iova,
 			umap_size, iova, mapped_iova_size);
 }
 
+static int uaudio_iommu_map_prot(bool dma_coherent)
+{
+	int prot = IOMMU_READ | IOMMU_WRITE;
+
+	if (dma_coherent)
+		prot |= IOMMU_CACHE;
+	return prot;
+}
+
 /**
- * uaudio_iommu_map() - maps iommu memory for adsp
+ * uaudio_iommu_map_pa() - maps iommu memory for adsp
  * @mtype: ring type
  * @dma_coherent: dma coherent
  * @pa: physical address for ring/buffer
  * @size: size of memory region
- * @sgt: sg table for memory region
  *
  * Maps the XHCI related resources to a memory region that is assigned to be
  * used by the adsp.  This will be mapped to the domain, which is created by
  * the ASoC USB backend driver.
  *
  */
-static unsigned long uaudio_iommu_map(enum mem_type mtype, bool dma_coherent,
-				      phys_addr_t pa, size_t size,
-				      struct sg_table *sgt)
+static unsigned long uaudio_iommu_map_pa(enum mem_type mtype, bool dma_coherent,
+					 phys_addr_t pa, size_t size)
 {
-	struct scatterlist *sg;
 	unsigned long iova = 0;
-	size_t total_len = 0;
-	unsigned long iova_sg;
-	phys_addr_t pa_sg;
 	bool map = true;
-	size_t sg_len;
-	int prot;
-	int ret;
-	int i;
-
-	prot = IOMMU_READ | IOMMU_WRITE;
-
-	if (dma_coherent)
-		prot |= IOMMU_CACHE;
+	int prot = uaudio_iommu_map_prot(dma_coherent);
 
 	switch (mtype) {
 	case MEM_EVENT_RING:
@@ -583,20 +578,41 @@ static unsigned long uaudio_iommu_map(enum mem_type mtype, bool dma_coherent,
 				     &uaudio_qdev->xfer_ring_iova_size,
 				     &uaudio_qdev->xfer_ring_list, size);
 		break;
-	case MEM_XFER_BUF:
-		iova = uaudio_get_iova(&uaudio_qdev->curr_xfer_buf_iova,
-				     &uaudio_qdev->xfer_buf_iova_size,
-				     &uaudio_qdev->xfer_buf_list, size);
-		break;
 	default:
 		dev_err(uaudio_qdev->data->dev, "unknown mem type %d\n", mtype);
 	}
 
 	if (!iova || !map)
-		goto done;
+		return 0;
 
-	if (!sgt)
-		goto skip_sgt_map;
+	iommu_map(uaudio_qdev->data->domain, iova, pa, size, prot, GFP_KERNEL);
+
+	return iova;
+}
+
+static unsigned long uaudio_iommu_map_xfer_buf(bool dma_coherent, size_t size,
+					       struct sg_table *sgt)
+{
+	struct scatterlist *sg;
+	unsigned long iova = 0;
+	size_t total_len = 0;
+	unsigned long iova_sg;
+	phys_addr_t pa_sg;
+	size_t sg_len;
+	int prot = uaudio_iommu_map_prot(dma_coherent);
+	int ret;
+	int i;
+
+	prot = IOMMU_READ | IOMMU_WRITE;
+
+	if (dma_coherent)
+		prot |= IOMMU_CACHE;
+
+	iova = uaudio_get_iova(&uaudio_qdev->curr_xfer_buf_iova,
+			       &uaudio_qdev->xfer_buf_iova_size,
+			       &uaudio_qdev->xfer_buf_list, size);
+	if (!iova)
+		goto done;
 
 	iova_sg = iova;
 	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
@@ -618,11 +634,6 @@ static unsigned long uaudio_iommu_map(enum mem_type mtype, bool dma_coherent,
 		uaudio_iommu_unmap(MEM_XFER_BUF, iova, size, total_len);
 		iova = 0;
 	}
-	return iova;
-
-skip_sgt_map:
-	iommu_map(uaudio_qdev->data->domain, iova, pa, size, prot, GFP_KERNEL);
-
 done:
 	return iova;
 }
@@ -1061,8 +1072,8 @@ static int uaudio_transfer_buffer_setup(struct snd_usb_substream *subs,
 			xfer_buf_dma, len);
 
 	/* map the physical buffer into sysdev as well */
-	xfer_buf_dma_sysdev = uaudio_iommu_map(MEM_XFER_BUF, dma_coherent,
-					       xfer_buf_pa, len, &xfer_buf_sgt);
+	xfer_buf_dma_sysdev = uaudio_iommu_map_xfer_buf(dma_coherent,
+							len, &xfer_buf_sgt);
 	if (!xfer_buf_dma_sysdev) {
 		ret = -ENOMEM;
 		goto unmap_sync;
@@ -1143,8 +1154,8 @@ uaudio_endpoint_setup(struct snd_usb_substream *subs,
 	sg_free_table(sgt);
 
 	/* data transfer ring */
-	iova = uaudio_iommu_map(MEM_XFER_RING, dma_coherent, tr_pa,
-			      PAGE_SIZE, NULL);
+	iova = uaudio_iommu_map_pa(MEM_XFER_RING, dma_coherent, tr_pa,
+				   PAGE_SIZE);
 	if (!iova) {
 		ret = -ENOMEM;
 		goto clear_pa;
@@ -1207,8 +1218,8 @@ static int uaudio_event_ring_setup(struct snd_usb_substream *subs,
 	mem_info->dma = sg_dma_address(sgt->sgl);
 	sg_free_table(sgt);
 
-	iova = uaudio_iommu_map(MEM_EVENT_RING, dma_coherent, er_pa,
-			      PAGE_SIZE, NULL);
+	iova = uaudio_iommu_map_pa(MEM_EVENT_RING, dma_coherent, er_pa,
+				   PAGE_SIZE);
 	if (!iova) {
 		ret = -ENOMEM;
 		goto clear_pa;

