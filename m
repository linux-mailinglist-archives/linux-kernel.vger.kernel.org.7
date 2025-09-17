Return-Path: <linux-kernel+bounces-820236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 899FDB7CD27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE1A3BF920
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4331309F17;
	Wed, 17 Sep 2025 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PBDACiDF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QJ+Z0pNd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PBDACiDF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QJ+Z0pNd"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F94309EF9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097830; cv=none; b=dPD5mJc6Tb2y6mt6apKN89E+u3V83afAhv+UU8UH3D8IXBfKMdSr0E6sZNYtwF+D38r6wX3WfDetV1iRijTrc8rjH0NEUyCrqDFTUC1J/KHAQzdWtEpjBEgSfVDu75kDKV6xI7L1LDWebwmHv7+QmbNn1YV0/VQuZirPACeMmaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097830; c=relaxed/simple;
	bh=r263QZaH/haYY7y8AZaPb5WwBGwfKTlrzV6p9bDwxOo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZio7dtmThJ7I9/6qnVOKxZvwE6Pacmo51iXzu3FkZFiKytIoXvOQRLD35dxYSyPZTR/FY0SWSmNyarKn/fkTT7Zu0K5wsVqLvWVfJkyHdtcaD67CzZCwWFhY1jNFS7QYKwAgIQVDUrillBNKqriNjgJVwGJ9+9XiMttxGgb+jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PBDACiDF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QJ+Z0pNd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PBDACiDF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QJ+Z0pNd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A32D21F5C;
	Wed, 17 Sep 2025 08:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758097826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+sqIYlTOc4VvhFqB052+i+xcgnDcdZsbd/L/En7eu28=;
	b=PBDACiDFdn2ni2peRlj+dANQNN7RIyVXFhNIG2f33EAQz0Xtb2qY9FmnmFGpW3TRV9MZVJ
	pwUeqm52mOJ2YAWvz8ydZaNsjqaA7wkQjfXYx8HshKet85In8is06Ssgx66BF64d2+tNgo
	4aFzg9ck7ux32CQ6tasCJcWKS7uP2fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758097826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+sqIYlTOc4VvhFqB052+i+xcgnDcdZsbd/L/En7eu28=;
	b=QJ+Z0pNdBrDOwjQm9vLsHet4EO1oJDXtcDbQLtPVObS4SCu1z8+e3Pec03VwPnVh1+IwpQ
	IFoqVU6IAnRDWBBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758097826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+sqIYlTOc4VvhFqB052+i+xcgnDcdZsbd/L/En7eu28=;
	b=PBDACiDFdn2ni2peRlj+dANQNN7RIyVXFhNIG2f33EAQz0Xtb2qY9FmnmFGpW3TRV9MZVJ
	pwUeqm52mOJ2YAWvz8ydZaNsjqaA7wkQjfXYx8HshKet85In8is06Ssgx66BF64d2+tNgo
	4aFzg9ck7ux32CQ6tasCJcWKS7uP2fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758097826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+sqIYlTOc4VvhFqB052+i+xcgnDcdZsbd/L/En7eu28=;
	b=QJ+Z0pNdBrDOwjQm9vLsHet4EO1oJDXtcDbQLtPVObS4SCu1z8+e3Pec03VwPnVh1+IwpQ
	IFoqVU6IAnRDWBBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A51E61368D;
	Wed, 17 Sep 2025 08:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O/f0JqFxymhnCQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 17 Sep 2025 08:30:25 +0000
Date: Wed, 17 Sep 2025 10:30:25 +0200
Message-ID: <87v7lhwkf2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Luca Weiss" <luca.weiss@fairphone.com>
Cc: "Takashi Iwai" <tiwai@suse.de>,
	"Arnd Bergmann" <arnd@arndb.de>,
	"Arnd Bergmann" <arnd@kernel.org>,
	"Mark Brown" <broonie@kernel.org>,
	"Wesley Cheng"
 <quic_wcheng@quicinc.com>,
	"Jaroslav Kysela" <perex@perex.cz>,
	"Takashi Iwai" <tiwai@suse.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Dan Carpenter" <dan.carpenter@linaro.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ALSA: qc_audio_offload: try to reduce address space confusion
In-Reply-To: <DCUXFIZ5KRCU.3JANM98BSE8SE@fairphone.com>
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
	<87o6raxtu9.wl-tiwai@suse.de>
	<DCUXFIZ5KRCU.3JANM98BSE8SE@fairphone.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Wed, 17 Sep 2025 10:19:23 +0200,
Luca Weiss wrote:
> 
> Hi Takashi,
> 
> On Tue Sep 16, 2025 at 6:09 PM CEST, Takashi Iwai wrote:
> > On Tue, 16 Sep 2025 10:41:01 +0200,
> > Luca Weiss wrote:
> >> 
> >> Hi Arnd,
> >> 
> >> On Fri Sep 5, 2025 at 4:54 PM CEST, Arnd Bergmann wrote:
> >> > On Fri, Sep 5, 2025, at 14:26, Takashi Iwai wrote:
> >> >> On Fri, 05 Sep 2025 13:47:28 +0200,
> >> >
> >> >> @@ -1051,18 +1050,13 @@ static int uaudio_transfer_buffer_setup(struct 
> >> >> snd_usb_substream *subs,
> >> >>  	if (!xfer_buf)
> >> >>  		return -ENOMEM;
> >> >> 
> >> >> -	/* Remapping is not possible if xfer_buf is outside of linear map */
> >> >> -	xfer_buf_pa = virt_to_phys(xfer_buf);
> >> >> -	if (WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))) {
> >> >> -		ret = -ENXIO;
> >> >> -		goto unmap_sync;
> >> >> -	}
> >> >>  	dma_get_sgtable(subs->dev->bus->sysdev, &xfer_buf_sgt, xfer_buf,
> >> >>  			xfer_buf_dma, len);
> >> >> 
> >> >>  	/* map the physical buffer into sysdev as well */
> >> >> +	/* note: 0 is passed to pa argument as we use sgt */
> >> >>  	xfer_buf_dma_sysdev = uaudio_iommu_map(MEM_XFER_BUF, dma_coherent,
> >> >> -					       xfer_buf_pa, len, &xfer_buf_sgt);
> >> >> +					       0, len, &xfer_buf_sgt);
> >> >>  	if (!xfer_buf_dma_sysdev) {
> >> >>  		ret = -ENOMEM;
> >> >>  		goto unmap_sync;
> >> >
> >> >
> >> > Makes sense. I had to rework the code a little more to actually
> >> > understand how it fits together, for reference the below version
> >> > (I don't expect it to build cleanly) would split up
> >> > uaudio_iommu_map() into one function that takes a physical
> >> > address and another function that takes an sg table.
> >> 
> >> Are you planning to post this as a proper patch? It's a bit late in the
> >> 6.17 cycle already but good to still get this fixed for final release.
> >> 
> >> Or revert the original commit that broke it for now.
> >> 
> >> I couldn't really test your patch since there's a couple of compile
> >> errors where I wasn't sure how to resolve them correctly.
> >
> > Could you check the patch below, then?  At least it compiles without
> > errors.
> 
> It does compile as well for me, but looks like it's not working.
> 
> It's still triggering the WARN_ON from
> 
>   if (WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))) {
> 
> [  214.157471] ------------[ cut here ]------------
> [  214.157491] WARNING: CPU: 4 PID: 12 at sound/usb/qcom/qc_audio_offload.c:1067 handle_uaudio_stream_req+0xecc/0x13c4
> [  214.157510] Modules linked in:
> [  214.157522] CPU: 4 UID: 0 PID: 12 Comm: kworker/u32:0 Tainted: G        W           6.16.0-00047-gfa3c1e37ba38 #1 NONE 
> [  214.157531] Tainted: [W]=WARN
> [  214.157535] Hardware name: Fairphone 4 (DT)
> [  214.157541] Workqueue: qmi_msg_handler qmi_data_ready_work
> [  214.157553] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  214.157560] pc : handle_uaudio_stream_req+0xecc/0x13c4
> [  214.157568] lr : handle_uaudio_stream_req+0xcdc/0x13c4
> [  214.157575] sp : ffff8000800b39d0
> [  214.157579] x29: ffff8000800b3b40 x28: ffff0000895eb6b0 x27: 0000000000008000
> [  214.157589] x26: ffff0000d6bae960 x25: ffffa11dbe275e28 x24: 0000000000008000
> [  214.157598] x23: ffffa11dbe0a4ec0 x22: ffff8000800b3c00 x21: 0000000000000000
> [  214.157608] x20: ffff8000800b3cc8 x19: ffff00008b128ac0 x18: ffffa11dbdfaa258
> [  214.157617] x17: ffff0000803e9388 x16: ffff0000800162c0 x15: ffffa11dbdfaa000
> [  214.157626] x14: 0000000000000500 x13: ffffa11dbe03c000 x12: 0000000000000000
> [  214.157636] x11: 0000000000000001 x10: 0000000000000001 x9 : ffffa11dbe0f78a0
> [  214.157645] x8 : ffffdee36909b000 x7 : ffff0000d6ac8418 x6 : 0000000000000000
> [  214.157654] x5 : 0000000000000000 x4 : ffff8000800b3968 x3 : 0000000000000000
> [  214.157663] x2 : 0000000000000000 x1 : ffff0000801a4100 x0 : 0000000000000000
> [  214.157672] Call trace:
> [  214.157677]  handle_uaudio_stream_req+0xecc/0x13c4 (P)
> [  214.157687]  qmi_invoke_handler+0xb4/0x100
> [  214.157694]  qmi_handle_message+0x88/0x1a0
> [  214.157702]  qmi_data_ready_work+0x208/0x35c
> [  214.157709]  process_one_work+0x144/0x2c4
> [  214.157719]  worker_thread+0x280/0x45c
> [  214.157726]  kthread+0xfc/0x1dc
> [  214.157733]  ret_from_fork+0x10/0x20
> [  214.157744] ---[ end trace 0000000000000000 ]---
> 
> Should that code be removed with the new code now?

Yes, please try the revised patch below.


thanks,

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
@@ -1020,7 +1031,6 @@ static int uaudio_transfer_buffer_setup(struct snd_usb_substream *subs,
 	struct sg_table xfer_buf_sgt;
 	dma_addr_t xfer_buf_dma;
 	void *xfer_buf;
-	phys_addr_t xfer_buf_pa;
 	u32 len = xfer_buf_len;
 	bool dma_coherent;
 	dma_addr_t xfer_buf_dma_sysdev;
@@ -1051,18 +1061,12 @@ static int uaudio_transfer_buffer_setup(struct snd_usb_substream *subs,
 	if (!xfer_buf)
 		return -ENOMEM;
 
-	/* Remapping is not possible if xfer_buf is outside of linear map */
-	xfer_buf_pa = virt_to_phys(xfer_buf);
-	if (WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))) {
-		ret = -ENXIO;
-		goto unmap_sync;
-	}
 	dma_get_sgtable(subs->dev->bus->sysdev, &xfer_buf_sgt, xfer_buf,
 			xfer_buf_dma, len);
 
 	/* map the physical buffer into sysdev as well */
-	xfer_buf_dma_sysdev = uaudio_iommu_map(MEM_XFER_BUF, dma_coherent,
-					       xfer_buf_pa, len, &xfer_buf_sgt);
+	xfer_buf_dma_sysdev = uaudio_iommu_map_xfer_buf(dma_coherent,
+							len, &xfer_buf_sgt);
 	if (!xfer_buf_dma_sysdev) {
 		ret = -ENOMEM;
 		goto unmap_sync;
@@ -1143,8 +1147,8 @@ uaudio_endpoint_setup(struct snd_usb_substream *subs,
 	sg_free_table(sgt);
 
 	/* data transfer ring */
-	iova = uaudio_iommu_map(MEM_XFER_RING, dma_coherent, tr_pa,
-			      PAGE_SIZE, NULL);
+	iova = uaudio_iommu_map_pa(MEM_XFER_RING, dma_coherent, tr_pa,
+				   PAGE_SIZE);
 	if (!iova) {
 		ret = -ENOMEM;
 		goto clear_pa;
@@ -1207,8 +1211,8 @@ static int uaudio_event_ring_setup(struct snd_usb_substream *subs,
 	mem_info->dma = sg_dma_address(sgt->sgl);
 	sg_free_table(sgt);
 
-	iova = uaudio_iommu_map(MEM_EVENT_RING, dma_coherent, er_pa,
-			      PAGE_SIZE, NULL);
+	iova = uaudio_iommu_map_pa(MEM_EVENT_RING, dma_coherent, er_pa,
+				   PAGE_SIZE);
 	if (!iova) {
 		ret = -ENOMEM;
 		goto clear_pa;

