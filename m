Return-Path: <linux-kernel+bounces-802874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAA0B457C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 198957BC49B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC14034F48B;
	Fri,  5 Sep 2025 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SYRQ9W7a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V4Kh5XJq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SYRQ9W7a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V4Kh5XJq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A497345738
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075217; cv=none; b=cbc4yw+wxb4ynhy8mUGt2uFoyCFxnxX003FPraMifJWPEBjyO+00WtcQsszz70fB064cLegflLlDt3CJ9EgWQg8ABTycYY3xyilnoucXcEfung9yjdX5eGJKeIfBveynkBxpXrnHF85c9zOCeYWAApFmCSw2mIKR5O4wl1G9IX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075217; c=relaxed/simple;
	bh=GfN82wVo5sRR/cioVFv5Q3a4VU5vBRPslau4m+964L0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkYrVYmZ1iHgWrkg0HJoWDBSB50i+YkWyOMJYYmSTI5lF8gj20Mu1r0xMvPAQVzVVWinATOyR47egmWogYkj2j1JdDeqjMIJ7ylZBPHE72As2y6YklwrbQvTqGB5nEjVZyWoEqKijwgTJr57l/J4nlWwcLneTRrIunO6t6O2j1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SYRQ9W7a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V4Kh5XJq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SYRQ9W7a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V4Kh5XJq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A55C5218;
	Fri,  5 Sep 2025 12:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757075211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7cM7yaI46Oyq30wqCn22wCJasA4AjDh02VVRenYT4A=;
	b=SYRQ9W7a4NXWZflHZ7o/d2RxRMyB2TzSvPw9AuATQwbO9JdQm9aSkg4AQe9VZW9KJ/J7IX
	InyTPFofKsZwsHbSf4E+LlCOgCKuRHhRg/03QsfiWip/KWxaEoxLokt9kg0CeOKsBNOKVc
	1fWUJG/qz0ooXvOGNDOdb653qH5UNTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757075211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7cM7yaI46Oyq30wqCn22wCJasA4AjDh02VVRenYT4A=;
	b=V4Kh5XJqawYLLjZ/eYvnTGnOf7ipjA5Sz5oPdiTlc9yUVilFWytcVKNB39bbt4Sw2ut4Eo
	Nk041PfjzvDJFzCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757075211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7cM7yaI46Oyq30wqCn22wCJasA4AjDh02VVRenYT4A=;
	b=SYRQ9W7a4NXWZflHZ7o/d2RxRMyB2TzSvPw9AuATQwbO9JdQm9aSkg4AQe9VZW9KJ/J7IX
	InyTPFofKsZwsHbSf4E+LlCOgCKuRHhRg/03QsfiWip/KWxaEoxLokt9kg0CeOKsBNOKVc
	1fWUJG/qz0ooXvOGNDOdb653qH5UNTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757075211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7cM7yaI46Oyq30wqCn22wCJasA4AjDh02VVRenYT4A=;
	b=V4Kh5XJqawYLLjZ/eYvnTGnOf7ipjA5Sz5oPdiTlc9yUVilFWytcVKNB39bbt4Sw2ut4Eo
	Nk041PfjzvDJFzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8DD913306;
	Fri,  5 Sep 2025 12:26:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LU9+LwrXumhEYgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 05 Sep 2025 12:26:50 +0000
Date: Fri, 05 Sep 2025 14:26:50 +0200
Message-ID: <87bjnpqe45.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Luca Weiss" <luca.weiss@fairphone.com>
Cc: "Takashi Iwai" <tiwai@suse.de>,
	"Arnd Bergmann" <arnd@kernel.org>,
	"Mark Brown" <broonie@kernel.org>,
	"Wesley Cheng" <quic_wcheng@quicinc.com>,
	"Arnd Bergmann" <arnd@arndb.de>,
	"Jaroslav Kysela" <perex@perex.cz>,
	"Takashi Iwai" <tiwai@suse.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Dan Carpenter"
 <dan.carpenter@linaro.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ALSA: qc_audio_offload: try to reduce address space confusion
In-Reply-To: <DCKUCB8A1JCV.1GK0TW2YMXNZP@fairphone.com>
References: <20250513123442.159936-1-arnd@kernel.org>
	<20250513123442.159936-4-arnd@kernel.org>
	<DBR2363A95M1.L9XBNC003490@fairphone.com>
	<87v7n72pg0.wl-tiwai@suse.de>
	<DBR3FZGY4QS1.BX6M1PZS5RH4@fairphone.com>
	<87ms8j2on6.wl-tiwai@suse.de>
	<DCKUCB8A1JCV.1GK0TW2YMXNZP@fairphone.com>
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
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,arndb.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Fri, 05 Sep 2025 13:47:28 +0200,
Luca Weiss wrote:
> 
> Hi Takashi,
> 
> Sorry for the late reply, things got in the way.
> 
> On Fri Aug 1, 2025 at 2:49 PM CEST, Takashi Iwai wrote:
> > On Fri, 01 Aug 2025 14:35:27 +0200,
> > Luca Weiss wrote:
> >> 
> >> Hi Takashi,
> >> 
> >> On Fri Aug 1, 2025 at 2:31 PM CEST, Takashi Iwai wrote:
> >> > On Fri, 01 Aug 2025 13:31:42 +0200,
> >> > Luca Weiss wrote:
> >> >> 
> >> >> Hi Arnd,
> >> >> 
> >> >> On Tue May 13, 2025 at 2:34 PM CEST, Arnd Bergmann wrote:
> >> >> > From: Arnd Bergmann <arnd@arndb.de>
> >> >> >
> >> >> > uaudio_transfer_buffer_setup() allocates a buffer for the subs->dev
> >> >> > device, and the returned address for the buffer is a CPU local virtual
> >> >> > address that may or may not be in the linear mapping, as well as a DMA
> >> >> > address token that is accessible by the USB device, and this in turn
> >> >> > may or may not correspond to the physical address.
> >> >> >
> >> >> > The use in the driver however assumes that these addresses are the
> >> >> > linear map and the CPU physical address, respectively. Both are
> >> >> > nonportable here, but in the end only the virtual address gets
> >> >> > used by converting it to a physical address that gets mapped into
> >> >> > a second iommu.
> >> >> >
> >> >> > Make this more explicit by pulling the conversion out first
> >> >> > and warning if it is not part of the linear map, and using the
> >> >> > actual physical address to map into the iommu in place of the
> >> >> > dma address that may already be iommu-mapped into the usb host.
> >> >> 
> >> >> This patch is breaking USB audio offloading on Qualcomm devices on 6.16,
> >> >> as tested on sm6350 and sc7280-based smartphones.
> >> >> 
> >> >> [  420.463176] q6afe-dai 3000000.remoteproc:glink-edge:apr:service@4:dais: AFE Port already open
> >> >> [  420.472676] ------------[ cut here ]------------
> >> >> [  420.472691] WARNING: CPU: 2 PID: 175 at sound/usb/qcom/qc_audio_offload.c:1056 handle_uaudio_stream_req+0xea8/0x13f8 [snd_usb_audio_qmi]
> >> >> [  420.472726] Modules linked in: rfcomm zram zsmalloc zstd_compress algif_hash algif_skcipher bnep nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink ipv6 fuse uhid uinput snd_usb_audio_qmi q6asm_dai q6routing q6afe_dai q6usb q6afe_clocks q6adm q6asm snd_q6dsp_common q6afe q6core apr pdr_interface snd_soc_sm8250 snd_soc_qcom
> >> >> _common snd_soc_qcom_offload_utils snd_soc_qcom_sdw soundwire_bus soc_usb snd_soc_core snd_compress snd_usb_audio ath10k_snoc ath10k_core snd_hwdep snd_usbmidi_lib ath fastrpc snd_pcm mac80211 hci_uart qrtr_smd snd_timer btqca qcom_pd_mapper snd_rawmidi bluetooth libarc4 qcom_pdr_msg cfg80211 snd soundcore ecdh_generic ecc rfkill qrtr qcom_stats qcom_q6v5_pas ipa qcom_pil_info qcom_q6v5 qcom_common
> >> >> [  420.473018] CPU: 2 UID: 0 PID: 175 Comm: kworker/u32:9 Tainted: G        W           6.16.0 #1-postmarketos-qcom-sm6350 NONE
> >> >> [  420.473033] Tainted: [W]=WARN
> >> >> [  420.473038] Hardware name: Fairphone 4 (DT)
> >> >> [  420.473045] Workqueue: qmi_msg_handler qmi_data_ready_work
> >> >> [  420.473065] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >> >> [  420.473075] pc : handle_uaudio_stream_req+0xea8/0x13f8 [snd_usb_audio_qmi]
> >> >> [  420.473091] lr : handle_uaudio_stream_req+0xc84/0x13f8 [snd_usb_audio_qmi]
> >> >> [  420.473104] sp : ffff800082f939a0
> >> >> [  420.473110] x29: ffff800082f93b10 x28: ffff0000cfb796b8 x27: 0000000000008000
> >> >> [  420.473128] x26: ffff0000842afc80 x25: ffffa8e75a23b0e0 x24: 0000000000008000
> >> >> [  420.473145] x23: ffffa8e75a23bcf0 x22: ffff800082f93bd0 x21: 0000000000000000
> >> >> [  420.473161] x20: ffff800082f93c98 x19: ffff0000939bb740 x18: ffffa8e77925a4d0
> >> >> [  420.473178] x17: ffffffffffffffff x16: ffffa8e777ef9728 x15: ffffa8e77925a000
> >> >> [  420.473194] x14: 0000000000000000 x13: 0000000000000dc0 x12: ffff800080000000
> >> >> [  420.473211] x11: 0000000000000cc0 x10: 0000000000000001 x9 : ffffa8e77944b880
> >> >> [  420.473227] x8 : ffffd719b5f4d000 x7 : ffff00009033da18 x6 : 0000000000000000
> >> >> [  420.473244] x5 : 0000000000000000 x4 : ffff800082f93938 x3 : 0000000000000000
> >> >> [  420.473260] x2 : 0000000000000000 x1 : ffff0000857790c0 x0 : 0000000000000000
> >> >> [  420.473277] Call trace:
> >> >> [  420.473283]  handle_uaudio_stream_req+0xea8/0x13f8 [snd_usb_audio_qmi] (P)
> >> >> [  420.473300]  qmi_invoke_handler+0xbc/0x108
> >> >> [  420.473314]  qmi_handle_message+0x90/0x1a8
> >> >> [  420.473326]  qmi_data_ready_work+0x210/0x390
> >> >> [  420.473339]  process_one_work+0x150/0x3a0
> >> >> [  420.473351]  worker_thread+0x288/0x480
> >> >> [  420.473362]  kthread+0x118/0x1e0
> >> >> [  420.473375]  ret_from_fork+0x10/0x20
> >> >> [  420.473390] ---[ end trace 0000000000000000 ]---
> >> >> [  420.479244] qcom-q6afe aprsvc:service:4:4: cmd = 0x100e5 returned error = 0x1
> >> >> [  420.479540] qcom-q6afe aprsvc:service:4:4: DSP returned error[1]
> >> >> [  420.479558] qcom-q6afe aprsvc:service:4:4: AFE enable for port 0x7000 failed -22
> >> >> [  420.479572] q6afe-dai 3000000.remoteproc:glink-edge:apr:service@4:dais: fail to start AFE port 88
> >> >> [  420.479583] q6afe-dai 3000000.remoteproc:glink-edge:apr:service@4:dais: ASoC error (-22): at snd_soc_dai_prepare() on USB_RX
> >> >> 
> >> >> Reverting this patch makes it work as expected on 6.16.0.
> >> >> 
> >> >> Let me know if I can be of any help to resolve this.
> >> >
> >> > I guess just dropping WARN_ON() would help?
> >> >
> >> > As far as I read the code, pa argument isn't used at all in
> >> > uaudio_iommu_map() unless as sgt is NULL.  In this case, sgt is never
> >> > NULL, hence the pa argument is just a placeholder.
> >> > That said, the whole xfer_buf_pa (and its sanity check) can be dropped
> >> > there.
> >> 
> >> Just the WARN splat is not the problem, it's actually failing
> >> afterwards. Without the patch it works as expected.
> >
> > OK, I wasn't clear enough; I meant to drop WARN_ON() *and* its error
> > handling:
> >
> > 	if (WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))) {
> > 		ret = -ENXIO;
> > 		goto unmap_sync;
> > 	}
> >
> > That is, replace WARN_ON() with 0.
> >
> > 	if (0 /*WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))*/) {
> > 		ret = -ENXIO;
> > 		goto unmap_sync;
> > 	}
> 
> Yes, that appears to work fine as well. Playback works again.
> 
> >
> > But you can try the patch I put in my previous reply instead (which
> > will remove all unneeded ).
> 
> That patch doesn't compile for me with this error:
> 
> In file included from ./include/uapi/linux/posix_types.h:5,
>                  from ./include/uapi/linux/types.h:14,
>                  from ./include/linux/types.h:6,
>                  from ./include/linux/kasan-checks.h:5,
>                  from ./include/asm-generic/rwonce.h:26,
>                  from ./arch/arm64/include/asm/rwonce.h:67,
>                  from ./include/linux/compiler.h:390,
>                  from ./include/linux/dev_printk.h:14,
>                  from ./include/linux/device.h:15,
>                  from ./include/linux/auxiliary_bus.h:11,
>                  from sound/usb/qcom/qc_audio_offload.c:6:
> sound/usb/qcom/qc_audio_offload.c: In function 'uaudio_transfer_buffer_setup':
> ./include/linux/stddef.h:8:14: error: passing argument 3 of 'uaudio_iommu_map' makes integer from pointer without a cast [-Wint-conversion]
>     8 | #define NULL ((void *)0)
>       |              ^~~~~~~~~~~
>       |              |
>       |              void *
> sound/usb/qcom/qc_audio_offload.c:1059:48: note: in expansion of macro 'NULL'
>  1059 |                                                NULL, len, &xfer_buf_sgt);
>       |                                                ^~~~
> sound/usb/qcom/qc_audio_offload.c:555:51: note: expected 'phys_addr_t' {aka 'long long unsigned int'} but argument is of type 'void *'
>   555 |                                       phys_addr_t pa, size_t size,
>       |                                       ~~~~~~~~~~~~^~

Then replace NULL with 0.  That is, like below.


Takashi

-- 8< --
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -1020,7 +1020,6 @@ static int uaudio_transfer_buffer_setup(struct snd_usb_substream *subs,
 	struct sg_table xfer_buf_sgt;
 	dma_addr_t xfer_buf_dma;
 	void *xfer_buf;
-	phys_addr_t xfer_buf_pa;
 	u32 len = xfer_buf_len;
 	bool dma_coherent;
 	dma_addr_t xfer_buf_dma_sysdev;
@@ -1051,18 +1050,13 @@ static int uaudio_transfer_buffer_setup(struct snd_usb_substream *subs,
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
+	/* note: 0 is passed to pa argument as we use sgt */
 	xfer_buf_dma_sysdev = uaudio_iommu_map(MEM_XFER_BUF, dma_coherent,
-					       xfer_buf_pa, len, &xfer_buf_sgt);
+					       0, len, &xfer_buf_sgt);
 	if (!xfer_buf_dma_sysdev) {
 		ret = -ENOMEM;
 		goto unmap_sync;

