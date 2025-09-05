Return-Path: <linux-kernel+bounces-803144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE605B45B14
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7968A7AC8C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B9A37C104;
	Fri,  5 Sep 2025 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XI+znNCD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zyg+gHrh"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069136CDE5;
	Fri,  5 Sep 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084086; cv=none; b=pdEqwCj0V8msWGopCmT8wkABYTtpoeZDd4hxkibuMPU4sP10wm2lKnUiW3mh1mtQ+bUhpyQjXH1/+bybSxc6mrraPp9Kt/ISV77Cu71iiOBiWMJHBv4LF4TBacBtZ8w7Ko9Ue4gk6wd7xwvPVS/FVyNq4JUaa8vWZ+ahjQ3+P1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084086; c=relaxed/simple;
	bh=zH4I7Gzopyb/6MKNHKYa8OVdx+ftcABF297zdepy2tE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DPW+7bBbPi+SgKd2jMvq8Q3QaIAEPwmnXwPIA5Rr33d4kpoj2mkbb7qcil03fMj3SiV/6GvQtPDayeEOXvXyHzmv7n4LwWEhv4H0y1slNF0NusaS5/a+bxmtTK8+ZeCdAbigNNBjFDfpuhf44zyiybYpvB9uuXl2UWr2EeR+Cwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XI+znNCD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zyg+gHrh; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 28F31EC02D6;
	Fri,  5 Sep 2025 10:54:43 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 05 Sep 2025 10:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757084083;
	 x=1757170483; bh=0UkrqJEXREoh6L/TfU0tfmsT28ith9kllz3OHAzvYbA=; b=
	XI+znNCD2iuWm2SyVrv9KVkqexXESs8EJHIYZ0C1YPp0d1VjlYooaJfbejuNo5YB
	qitjNN/3a2iMX252fvMQtkT7DqXzggRNvhQZrppn8YbPA4ygRAHYe/mIioTAnuDg
	+lqtGa0BqCe2Tzvuh9goni7U0F3rrI1LQ5kUUSJbjd6K0Fi0dOSc+wHdJbHmwAoo
	OLNBhX5zomoyaA89vPE5i8kwttZcR9WM+EfoEycu13wqIQDCab7m9/D0Y3Hh22r7
	TMi9BrFDLyTtpRRqazLxrySGiwZLU8JJRRLKaU3OY68z0IHgyZzSW6Ec0Vi+/ojn
	1DWl5EfcWtPfcOgWnPPiPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757084083; x=
	1757170483; bh=0UkrqJEXREoh6L/TfU0tfmsT28ith9kllz3OHAzvYbA=; b=Z
	yg+gHrhzIi8deB/erZ0BGCPG2ZJwzi1DpvRkB/RS/i3Dnw6qnhSQqSzjuoTZe8ff
	aGdMvbasaURqo2EYslQ44mXcMzQ5wrjAI09UJ/J2lJpPMzZ0O8Og++xe07l2dLu3
	UODnshOjd3d6gmZKBQQAJJNKoFUEn9qMulJuMOXU00J9wr3u/gx4vzDh1aSz/Dfw
	EW5i9wIm33uc0iil2Cy56MU244ZJLevnhECK1D0TszE8P4DC2hm3oQs4A2HpLZx+
	ei7yHy3koQd7JUXsc0R7yR8vyGcy0G5BUh1JZV2rNyA7wRMjNi5GCB3Y+gh7Y7pf
	v8ruN3UXAZGrSQUEswnnA==
X-ME-Sender: <xms:svm6aCHWP1ibHs6ltiyJslw7KtRM-PPykVRkuQazcV1E0yhtPTwSDA>
    <xme:svm6aDXu8TlasNJDZZkk57ksBeDKFXnkwGXtAsdPuGsRH_DhNo0C6Ew9rom3qgUDB
    is47Xwl_yWSiK6aY0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeludekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    ephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehluhgtrgdrfigvihhsshesfhgrihhrphhhohhnvgdrtghomhdprhgtph
    htthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrohhonhhivges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhinh
    grrhhordhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtohepphgvrhgvgiesphgvrhgvgidrtgiipdhrtghpthhtoh
    epqhhuihgtpgiftghhvghnghesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehtihif
    rghisehsuhhsvgdrtghomhdprhgtphhtthhopehtihifrghisehsuhhsvgdruggv
X-ME-Proxy: <xmx:svm6aBdd6sdJaS4iM8ZekJBl781EkxBaxN3pUZlU7Kj8RpeVMg39nQ>
    <xmx:svm6aOZna0HMFrm1HVpB0daD5el3soTGd0NcF_7NQZDLaJmMkFHvTQ>
    <xmx:svm6aNNLTVOzZTZn2jiE8iz9roMgfaUOg7bjeDvro6SOAnL8657WsA>
    <xmx:svm6aEUU3pINoss3x4CJ1U46IzlVnqlfXeqDmwjU9XIrtDX_wo1CYg>
    <xmx:s_m6aGHGE-kFQlcBG98dfWv-A2gAyBN3cR4kizYE5MZg9bQBJmZr_4lw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B900F700069; Fri,  5 Sep 2025 10:54:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ-KNcceaLbJ
Date: Fri, 05 Sep 2025 16:54:06 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Takashi Iwai" <tiwai@suse.de>, "Luca Weiss" <luca.weiss@fairphone.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Wesley Cheng" <quic_wcheng@quicinc.com>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <a2a6843f-7e03-4b7e-b5fc-415ac9fc6621@app.fastmail.com>
In-Reply-To: <87bjnpqe45.wl-tiwai@suse.de>
References: <20250513123442.159936-1-arnd@kernel.org>
 <20250513123442.159936-4-arnd@kernel.org>
 <DBR2363A95M1.L9XBNC003490@fairphone.com> <87v7n72pg0.wl-tiwai@suse.de>
 <DBR3FZGY4QS1.BX6M1PZS5RH4@fairphone.com> <87ms8j2on6.wl-tiwai@suse.de>
 <DCKUCB8A1JCV.1GK0TW2YMXNZP@fairphone.com> <87bjnpqe45.wl-tiwai@suse.de>
Subject: Re: [PATCH 3/3] ALSA: qc_audio_offload: try to reduce address space confusion
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 5, 2025, at 14:26, Takashi Iwai wrote:
> On Fri, 05 Sep 2025 13:47:28 +0200,

> @@ -1051,18 +1050,13 @@ static int uaudio_transfer_buffer_setup(struct 
> snd_usb_substream *subs,
>  	if (!xfer_buf)
>  		return -ENOMEM;
> 
> -	/* Remapping is not possible if xfer_buf is outside of linear map */
> -	xfer_buf_pa = virt_to_phys(xfer_buf);
> -	if (WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))) {
> -		ret = -ENXIO;
> -		goto unmap_sync;
> -	}
>  	dma_get_sgtable(subs->dev->bus->sysdev, &xfer_buf_sgt, xfer_buf,
>  			xfer_buf_dma, len);
> 
>  	/* map the physical buffer into sysdev as well */
> +	/* note: 0 is passed to pa argument as we use sgt */
>  	xfer_buf_dma_sysdev = uaudio_iommu_map(MEM_XFER_BUF, dma_coherent,
> -					       xfer_buf_pa, len, &xfer_buf_sgt);
> +					       0, len, &xfer_buf_sgt);
>  	if (!xfer_buf_dma_sysdev) {
>  		ret = -ENOMEM;
>  		goto unmap_sync;


Makes sense. I had to rework the code a little more to actually
understand how it fits together, for reference the below version
(I don't expect it to build cleanly) would split up
uaudio_iommu_map() into one function that takes a physical
address and another function that takes an sg table.

       Arnd

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index a25c5a531690..f843c2181da5 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -539,32 +539,24 @@ static void uaudio_iommu_unmap(enum mem_type mtype, unsigned long iova,
 }
 
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
+				      phys_addr_t pa, size_t size)
 {
 	struct scatterlist *sg;
 	unsigned long iova = 0;
-	size_t total_len = 0;
-	unsigned long iova_sg;
-	phys_addr_t pa_sg;
 	bool map = true;
-	size_t sg_len;
 	int prot;
-	int ret;
-	int i;
 
 	prot = IOMMU_READ | IOMMU_WRITE;
 
@@ -583,20 +575,42 @@ static unsigned long uaudio_iommu_map(enum mem_type mtype, bool dma_coherent,
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
+done:
+	return iova;
+}
+
+static unsigned long uaudio_iommu_map_xfer_buf(bool dma_coherent,
+				      size_t size, struct sg_table *sgt)
+{
+	struct scatterlist *sg;
+	unsigned long iova = 0;
+	size_t total_len = 0;
+	unsigned long iova_sg;
+	phys_addr_t pa_sg;
+	size_t sg_len;
+	int prot;
+	int ret;
+	int i;
+
+	prot = IOMMU_READ | IOMMU_WRITE;
+
+	if (dma_coherent)
+		prot |= IOMMU_CACHE;
+
+	iova = uaudio_get_iova(&uaudio_qdev->curr_xfer_buf_iova,
+			     &uaudio_qdev->xfer_buf_iova_size,
+			     &uaudio_qdev->xfer_buf_list, size);
+	if (!iova)
+		goto done;
 
 	iova_sg = iova;
 	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
@@ -618,11 +632,6 @@ static unsigned long uaudio_iommu_map(enum mem_type mtype, bool dma_coherent,
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
@@ -1061,8 +1070,8 @@ static int uaudio_transfer_buffer_setup(struct snd_usb_substream *subs,
 			xfer_buf_dma, len);
 
 	/* map the physical buffer into sysdev as well */
-	xfer_buf_dma_sysdev = uaudio_iommu_map(MEM_XFER_BUF, dma_coherent,
-					       xfer_buf_pa, len, &xfer_buf_sgt);
+	xfer_buf_dma_sysdev = uaudio_iommu_map_xfer_buf(dma_coherent, xfer_buf_pa,
+							len, &xfer_buf_sgt);
 	if (!xfer_buf_dma_sysdev) {
 		ret = -ENOMEM;
 		goto unmap_sync;
@@ -1143,8 +1152,8 @@ uaudio_endpoint_setup(struct snd_usb_substream *subs,
 	sg_free_table(sgt);
 
 	/* data transfer ring */
-	iova = uaudio_iommu_map(MEM_XFER_RING, dma_coherent, tr_pa,
-			      PAGE_SIZE, NULL);
+	iova = uaudio_iommu_map_pa(MEM_XFER_RING, dma_coherent, tr_pa,
+				   PAGE_SIZE);
 	if (!iova) {
 		ret = -ENOMEM;
 		goto clear_pa;
@@ -1207,8 +1216,8 @@ static int uaudio_event_ring_setup(struct snd_usb_substream *subs,
 	mem_info->dma = sg_dma_address(sgt->sgl);
 	sg_free_table(sgt);
 
-	iova = uaudio_iommu_map(MEM_EVENT_RING, dma_coherent, er_pa,
-			      PAGE_SIZE, NULL);
+	iova = uaudio_iommu_map_pa(MEM_EVENT_RING, dma_coherent, er_pa,
+				   PAGE_SIZE);
 	if (!iova) {
 		ret = -ENOMEM;
 		goto clear_pa;

