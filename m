Return-Path: <linux-kernel+bounces-753369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B99DB181FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFC4A873AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D876238D32;
	Fri,  1 Aug 2025 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g60m6LS2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6lAIXe10";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MXd9foKH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DETzfZGO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B65208CA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754052551; cv=none; b=hjbnM74aD6rJF+tZydkrRLChG25q3rEqQz/g0NMbIyNzyV770qTVf/H8V9fjvU+GndJvpsWIAZoCvrFxghH2nQiGzTQ3jgTSDvb+Csvb0Cj65eiqcZVMeSi6gd6dwetC0ylX3vElyXbEJ3iVqyFwG4DR/lRUuDRR+Y99k2qbUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754052551; c=relaxed/simple;
	bh=ZaApghpGN2VK6dMh0+fonbPznALxPQauOeZ1U9SKD6A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyUA1a17OTV5LBvg1XZGm0Yq5RRXDmUcilKwYHW53jIHqV1/USLgLqRTiOvsYZdM+ut62DXv9TEV8DR2pnSt8zYodVnlXseKXtL+W1XnTSH6B43mfc/6XX0YblhTpJ9+pCtS6QlGBzP3Eq4/E4CZLtw2pVDmQwF4Ei/ehNq8x6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g60m6LS2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6lAIXe10; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MXd9foKH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DETzfZGO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E562621994;
	Fri,  1 Aug 2025 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754052542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1A8mzKDW6UCV8f8KZBOuc6uQbJ/jpsP8SQE16agHhQ=;
	b=g60m6LS2zBPc4pSjKltpCl6MKn9dkMysZHewk7P2X/Y2LDkrd5V9U2mGHduo0YguY10gkb
	Bg9+c4k2K1i1htWASA0VQcp1Vdau5DdHreMrn+ajxg/HDzz2kXGEPpnN/6smHkwF9Txqhc
	xktXdBNvG7BVfoZrJzz9q68ygn8cPcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754052542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1A8mzKDW6UCV8f8KZBOuc6uQbJ/jpsP8SQE16agHhQ=;
	b=6lAIXe10DCm/FqkG8bHp7UEwfYmcvUzCSqM5uJnWQXi2p485bd2TL4cw4sCgUt9D+v8sNK
	gjsLUBu21oAxArCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MXd9foKH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DETzfZGO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754052541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1A8mzKDW6UCV8f8KZBOuc6uQbJ/jpsP8SQE16agHhQ=;
	b=MXd9foKHinUMHEsGC1qUhmk4rYrn89NHMD8jh3yKUZxWWnnmgphZTBKk8SIHF1QN1neOYz
	bIFa0g5OfaploD9+LIa4MheQ6TJ5hooZSB0z2cXeJqnmDrhrrc4/GalsrDuoGnXBdQzH9j
	tDZjOtByAN3W94lIOeuJeVmf8IPaR2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754052541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1A8mzKDW6UCV8f8KZBOuc6uQbJ/jpsP8SQE16agHhQ=;
	b=DETzfZGOh5faVOLr16EXjIlHgLTgO5NCQ+LVmXHkdhvfLOyxoQcE3+v3t6c5rFxZUuiz1+
	y9lJsnwd0bquC6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9346713876;
	Fri,  1 Aug 2025 12:49:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uppKIb23jGieegAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 01 Aug 2025 12:49:01 +0000
Date: Fri, 01 Aug 2025 14:49:01 +0200
Message-ID: <87ms8j2on6.wl-tiwai@suse.de>
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
In-Reply-To: <DBR3FZGY4QS1.BX6M1PZS5RH4@fairphone.com>
References: <20250513123442.159936-1-arnd@kernel.org>
	<20250513123442.159936-4-arnd@kernel.org>
	<DBR2363A95M1.L9XBNC003490@fairphone.com>
	<87v7n72pg0.wl-tiwai@suse.de>
	<DBR3FZGY4QS1.BX6M1PZS5RH4@fairphone.com>
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
X-Rspamd-Queue-Id: E562621994
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,arndb.de:email,suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.51

On Fri, 01 Aug 2025 14:35:27 +0200,
Luca Weiss wrote:
> 
> Hi Takashi,
> 
> On Fri Aug 1, 2025 at 2:31 PM CEST, Takashi Iwai wrote:
> > On Fri, 01 Aug 2025 13:31:42 +0200,
> > Luca Weiss wrote:
> >> 
> >> Hi Arnd,
> >> 
> >> On Tue May 13, 2025 at 2:34 PM CEST, Arnd Bergmann wrote:
> >> > From: Arnd Bergmann <arnd@arndb.de>
> >> >
> >> > uaudio_transfer_buffer_setup() allocates a buffer for the subs->dev
> >> > device, and the returned address for the buffer is a CPU local virtual
> >> > address that may or may not be in the linear mapping, as well as a DMA
> >> > address token that is accessible by the USB device, and this in turn
> >> > may or may not correspond to the physical address.
> >> >
> >> > The use in the driver however assumes that these addresses are the
> >> > linear map and the CPU physical address, respectively. Both are
> >> > nonportable here, but in the end only the virtual address gets
> >> > used by converting it to a physical address that gets mapped into
> >> > a second iommu.
> >> >
> >> > Make this more explicit by pulling the conversion out first
> >> > and warning if it is not part of the linear map, and using the
> >> > actual physical address to map into the iommu in place of the
> >> > dma address that may already be iommu-mapped into the usb host.
> >> 
> >> This patch is breaking USB audio offloading on Qualcomm devices on 6.16,
> >> as tested on sm6350 and sc7280-based smartphones.
> >> 
> >> [  420.463176] q6afe-dai 3000000.remoteproc:glink-edge:apr:service@4:dais: AFE Port already open
> >> [  420.472676] ------------[ cut here ]------------
> >> [  420.472691] WARNING: CPU: 2 PID: 175 at sound/usb/qcom/qc_audio_offload.c:1056 handle_uaudio_stream_req+0xea8/0x13f8 [snd_usb_audio_qmi]
> >> [  420.472726] Modules linked in: rfcomm zram zsmalloc zstd_compress algif_hash algif_skcipher bnep nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink ipv6 fuse uhid uinput snd_usb_audio_qmi q6asm_dai q6routing q6afe_dai q6usb q6afe_clocks q6adm q6asm snd_q6dsp_common q6afe q6core apr pdr_interface snd_soc_sm8250 snd_soc_qcom
> >> _common snd_soc_qcom_offload_utils snd_soc_qcom_sdw soundwire_bus soc_usb snd_soc_core snd_compress snd_usb_audio ath10k_snoc ath10k_core snd_hwdep snd_usbmidi_lib ath fastrpc snd_pcm mac80211 hci_uart qrtr_smd snd_timer btqca qcom_pd_mapper snd_rawmidi bluetooth libarc4 qcom_pdr_msg cfg80211 snd soundcore ecdh_generic ecc rfkill qrtr qcom_stats qcom_q6v5_pas ipa qcom_pil_info qcom_q6v5 qcom_common
> >> [  420.473018] CPU: 2 UID: 0 PID: 175 Comm: kworker/u32:9 Tainted: G        W           6.16.0 #1-postmarketos-qcom-sm6350 NONE
> >> [  420.473033] Tainted: [W]=WARN
> >> [  420.473038] Hardware name: Fairphone 4 (DT)
> >> [  420.473045] Workqueue: qmi_msg_handler qmi_data_ready_work
> >> [  420.473065] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >> [  420.473075] pc : handle_uaudio_stream_req+0xea8/0x13f8 [snd_usb_audio_qmi]
> >> [  420.473091] lr : handle_uaudio_stream_req+0xc84/0x13f8 [snd_usb_audio_qmi]
> >> [  420.473104] sp : ffff800082f939a0
> >> [  420.473110] x29: ffff800082f93b10 x28: ffff0000cfb796b8 x27: 0000000000008000
> >> [  420.473128] x26: ffff0000842afc80 x25: ffffa8e75a23b0e0 x24: 0000000000008000
> >> [  420.473145] x23: ffffa8e75a23bcf0 x22: ffff800082f93bd0 x21: 0000000000000000
> >> [  420.473161] x20: ffff800082f93c98 x19: ffff0000939bb740 x18: ffffa8e77925a4d0
> >> [  420.473178] x17: ffffffffffffffff x16: ffffa8e777ef9728 x15: ffffa8e77925a000
> >> [  420.473194] x14: 0000000000000000 x13: 0000000000000dc0 x12: ffff800080000000
> >> [  420.473211] x11: 0000000000000cc0 x10: 0000000000000001 x9 : ffffa8e77944b880
> >> [  420.473227] x8 : ffffd719b5f4d000 x7 : ffff00009033da18 x6 : 0000000000000000
> >> [  420.473244] x5 : 0000000000000000 x4 : ffff800082f93938 x3 : 0000000000000000
> >> [  420.473260] x2 : 0000000000000000 x1 : ffff0000857790c0 x0 : 0000000000000000
> >> [  420.473277] Call trace:
> >> [  420.473283]  handle_uaudio_stream_req+0xea8/0x13f8 [snd_usb_audio_qmi] (P)
> >> [  420.473300]  qmi_invoke_handler+0xbc/0x108
> >> [  420.473314]  qmi_handle_message+0x90/0x1a8
> >> [  420.473326]  qmi_data_ready_work+0x210/0x390
> >> [  420.473339]  process_one_work+0x150/0x3a0
> >> [  420.473351]  worker_thread+0x288/0x480
> >> [  420.473362]  kthread+0x118/0x1e0
> >> [  420.473375]  ret_from_fork+0x10/0x20
> >> [  420.473390] ---[ end trace 0000000000000000 ]---
> >> [  420.479244] qcom-q6afe aprsvc:service:4:4: cmd = 0x100e5 returned error = 0x1
> >> [  420.479540] qcom-q6afe aprsvc:service:4:4: DSP returned error[1]
> >> [  420.479558] qcom-q6afe aprsvc:service:4:4: AFE enable for port 0x7000 failed -22
> >> [  420.479572] q6afe-dai 3000000.remoteproc:glink-edge:apr:service@4:dais: fail to start AFE port 88
> >> [  420.479583] q6afe-dai 3000000.remoteproc:glink-edge:apr:service@4:dais: ASoC error (-22): at snd_soc_dai_prepare() on USB_RX
> >> 
> >> Reverting this patch makes it work as expected on 6.16.0.
> >> 
> >> Let me know if I can be of any help to resolve this.
> >
> > I guess just dropping WARN_ON() would help?
> >
> > As far as I read the code, pa argument isn't used at all in
> > uaudio_iommu_map() unless as sgt is NULL.  In this case, sgt is never
> > NULL, hence the pa argument is just a placeholder.
> > That said, the whole xfer_buf_pa (and its sanity check) can be dropped
> > there.
> 
> Just the WARN splat is not the problem, it's actually failing
> afterwards. Without the patch it works as expected.

OK, I wasn't clear enough; I meant to drop WARN_ON() *and* its error
handling:

	if (WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))) {
		ret = -ENXIO;
		goto unmap_sync;
	}

That is, replace WARN_ON() with 0.

	if (0 /*WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))*/) {
		ret = -ENXIO;
		goto unmap_sync;
	}

But you can try the patch I put in my previous reply instead (which
will remove all unneeded ).


thanks,

Takashi

