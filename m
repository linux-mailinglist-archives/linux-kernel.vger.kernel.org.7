Return-Path: <linux-kernel+bounces-802935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B35B4588D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525F758446E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813D61C860B;
	Fri,  5 Sep 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="c6xA49R1"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A042D11713
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078250; cv=none; b=X37L7ZhGNjzEVIYJqH3aUYS/T3X/WqqTffltSK+WkpA/2XkD4uEK5hww8MvQRWhf0xtGGrddC2o4O6elpcfYdFN+Z7pMB6L108FLjAFUDM5Xrg5BoY9nRJ8M22MILQvPMnvDYP/4H5uNlaFE20L4E/1191w2hzSJimw7OZ+aCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078250; c=relaxed/simple;
	bh=Zkcfo2o+FE6Dr4HEv24TNQj8qmjc9xyPL7FgDWm8KHI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=klYD1Sc94/pXFDuRcBW0Lqe3uwTQSzDwyPpd7oYUIKuMyHq3O0ow1zMPcdo6LdmikII/wVsxYbXBr+EQ75DgL4F/m7N8gcNb4LojxCgmLEqy9abIe5lt3H61c8GN2R9YpCpH4qhk+O/6L2ur4LXNPA3CAiFNjZEob5mOLL4/IV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=c6xA49R1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b84367affso18975345e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1757078247; x=1757683047; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJshM4vbpP3v/V9FLXmj0qYGNjvFFxUjZMAI3TJgc4s=;
        b=c6xA49R1lZZsa9lNUDxW7ls82CgEr7aqABHU7cnhytHRQvvj//CMif2c8OEQa4BhXx
         THk7tSxPunxlyjYbvLKIsVjS260BXBbW0Jj/fdAyaIs+IiNiPpjcXwADWzDdIx5nwumh
         CPo1EHeUrjeW9Bsrh48RPPPGO+zMQj/6FnGBKqnta9ArhlrFZmOpNFZHk3rxyl2VWG9j
         Q2wGQkmLdWYqBghfceBEFaNRcIQiA1sl+0NOWdS3IpzbLpbOpyd91wBpqU4Lqnvn6dHs
         X30RynKOlxgcK3UjQjemdGs0c1zIvyLo8lOcMSAqxXUt7Pr6PP8+kxVee6379qWWBTU+
         kKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078247; x=1757683047;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WJshM4vbpP3v/V9FLXmj0qYGNjvFFxUjZMAI3TJgc4s=;
        b=rw6d8RFZRSxB1Kz/4TJEpz0+QraJgwmBncwLvudEICACCgSmNmHzIPydYHmRPrognv
         34sOsRIdHHRtQRh49zLjXiyU/sCkK4itm2aQMDP/fAn9f3SFMI0L9nmkMJyNcL3KM6xm
         KdemoZRgEx3Fhf+Mpyzh5Z0XmzSX/n4o/I6hNZXwpLFWZUeFpKG4Hl/NESp0B18C9eTx
         FfMVOJmKC60zfPFded4yaEcHIxiOPfjKF/xWG/EI1XTh2ITtESE8kXTZcBf1EDzWqfzL
         hBsrKgTyl3Mfah0WiKa/dv4jmDu/Cn54dI91L6gIH5ZTTnQtswSmZUrkMyeL2FKVqqB5
         8Z9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjEUNCEZzPZm66bP7sHgPo70fpz9i5teh9DNUkZkjIRd+lVIIP9AW16kOrYVtlz/fd0nwSq6TJ9F+D9oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDdkJ6LEEGCbnPkYH5itGUlG5HsPyjJ7SGEKUDy5IcXX9hd798
	IjuzUBhu+0fOgAB/Sst0j9/bbycjxh25VXFxrBAaN0C1WBqJP7373lOXOxX7XJWPjKU=
X-Gm-Gg: ASbGncsXIXJGwbdPnhu4KST8xxpECntDWF5ZqJ28xJGboa1LsZrCw4b7EK+Ved021bZ
	sHNqDBYTs7n5l8Cek5Eljp94bo70tXGQTq3NMsYe04VKY0V3fez3WwsHkjfKXn8lSwsREGCauhE
	FiRkDo/SL+NX748izZCLvvUdXVrUkYne3c2gHR7X+SrMpXVo81Hq1bUZQMS8CveTMwbXcjsMVP3
	gc1sGVRT/BLkIbIh7itumuPk3SkQfaeDVm/IMHM5yo4LNQrAywaSx0MVsLjRYvQzpy4I8FQbkeT
	JG/zqDsSIuRT09WqR4mzP4OAzlO7RNz25kwmra24bIulwXxu2fLZT9jF4TB6RM0cNUuiw9dED2J
	HumoM7WfM8z0vQUq6mq0ESplN1/YOZQOg75YKkIROmW013wJf5QnShmtkYhdaf1rOdbcScTIOCP
	uZy83UCcY4GZSij3q6Jxl/UKvWjw06lec=
X-Google-Smtp-Source: AGHT+IEak2G8rifngU86etW0UMHLHxbdNZaCmkkUUn45TG2/kT+5jZbAiVE6FF/g7hrDJkNzPjebNA==
X-Received: by 2002:a05:600c:35cb:b0:45d:cf5f:cff8 with SMTP id 5b1f17b1804b1-45ddc315be7mr8083565e9.11.1757078246688;
        Fri, 05 Sep 2025 06:17:26 -0700 (PDT)
Received: from localhost (ip-185-104-138-128.ptr.icomera.net. [185.104.138.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d978ab6fc7sm16412039f8f.45.2025.09.05.06.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 06:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Sep 2025 15:17:20 +0200
Message-Id: <DCKW943MHDZO.3QJRSTIXDW1C4@fairphone.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Wesley Cheng" <quic_wcheng@quicinc.com>, "Jaroslav Kysela"
 <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Dan Carpenter" <dan.carpenter@linaro.org>,
 <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ALSA: qc_audio_offload: try to reduce address space
 confusion
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Arnd Bergmann" <arnd@arndb.de>, "Takashi Iwai" <tiwai@suse.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250513123442.159936-1-arnd@kernel.org>
 <20250513123442.159936-4-arnd@kernel.org>
 <DBR2363A95M1.L9XBNC003490@fairphone.com> <87v7n72pg0.wl-tiwai@suse.de>
 <DBR3FZGY4QS1.BX6M1PZS5RH4@fairphone.com> <87ms8j2on6.wl-tiwai@suse.de>
 <DCKUCB8A1JCV.1GK0TW2YMXNZP@fairphone.com>
 <246834be-9e72-432e-86e4-e1c68262e710@app.fastmail.com>
In-Reply-To: <246834be-9e72-432e-86e4-e1c68262e710@app.fastmail.com>

Hi Arnd,

On Fri Sep 5, 2025 at 2:08 PM CEST, Arnd Bergmann wrote:
> On Fri, Sep 5, 2025, at 13:47, Luca Weiss wrote:
>> On Fri Aug 1, 2025 at 2:49 PM CEST, Takashi Iwai wrote:
>>> On Fri, 01 Aug 2025 14:35:27 +0200,
>>>> On Fri Aug 1, 2025 at 2:31 PM CEST, Takashi Iwai wrote:
>>>> > On Fri, 01 Aug 2025 13:31:42 +0200,
>>>> >> On Tue May 13, 2025 at 2:34 PM CEST, Arnd Bergmann wrote:
>>>> >> >
>>>> >> > Make this more explicit by pulling the conversion out first
>>>> >> > and warning if it is not part of the linear map, and using the
>>>> >> > actual physical address to map into the iommu in place of the
>>>> >> > dma address that may already be iommu-mapped into the usb host.
>>>> >>=20
>>>> >> This patch is breaking USB audio offloading on Qualcomm devices on =
6.16,
>>>> >> as tested on sm6350 and sc7280-based smartphones.
>>>> >>=20
>>>> >> Let me know if I can be of any help to resolve this.
>>>> >
>>>> > I guess just dropping WARN_ON() would help?
>>>> >
>>>> > As far as I read the code, pa argument isn't used at all in
>>>> > uaudio_iommu_map() unless as sgt is NULL.  In this case, sgt is neve=
r
>>>> > NULL, hence the pa argument is just a placeholder.
>>>> > That said, the whole xfer_buf_pa (and its sanity check) can be dropp=
ed
>>>> > there.
>>>>=20
>>>> Just the WARN splat is not the problem, it's actually failing
>>>> afterwards. Without the patch it works as expected.
>>>
>>> That is, replace WARN_ON() with 0.
>>>
>>> 	if (0 /*WARN_ON(!page_is_ram(PFN_DOWN(xfer_buf_pa)))*/) {
>>> 		ret =3D -ENXIO;
>>> 		goto unmap_sync;
>>> 	}
>>
>> Yes, that appears to work fine as well. Playback works again.
>>
>
> This does mean that the address returned from xfer_buf is not
> a kernel address in the virtual map though, and converting it
> through virt_to_phys() makes the pa undefined for
> uaudio_iommu_map(). Can you print what that pa value
> is that you get here, and where that sits in the address space?

Adding a debug print gives me the following below.

  dev_err(uaudio_qdev->data->dev, "xfer_buf_pa=3D%llx\n", xfer_buf_pa);

Not sure what exactly you mean with "where that sits in the address
space" and how I can figure that out.

[  130.124938] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0486ea6000
[  130.141583] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0484be5000
[  130.145826] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0484bfd000
[  130.150031] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0484c0d000
[  130.155437] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0484ec5000
[  130.159573] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0484f0d000
[  130.164778] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0484f2d000
[  130.180878] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0484fe5000
[  130.185178] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0485005000
[  130.189393] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba048507d000
[  130.194323] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba04850e5000
[  130.198375] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba048561d000
[  130.202280] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0485655000
[  130.215915] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba04856a5000
[  130.219701] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0486f15000
[  130.223351] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba04870b5000
[  130.227881] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba04871bd000
[  130.231780] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba04871dd000
[  130.235432] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba04871f5000
[  130.249669] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0487525000
[  130.253451] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba048755d000
[  130.257113] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba048758d000
[  130.261473] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba04875c5000
[  130.265226] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba04875d5000
[  130.268856] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba04875de000
[  130.283635] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0486ed3000
[  130.287445] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0486eca000
[  130.291147] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba04875e7000
[  130.295957] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba04875f0000
[  130.299995] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0489fd5000
[  130.303607] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0489fde000
[  130.317503] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0489fe7000
[  130.321291] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba0489ff0000
[  130.324979] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba048a005000
[  130.329604] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba048a00e000
[  130.333397] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba048a01d000
[  130.337089] q6usb-dai 3000000.remoteproc:glink-edge:apr:service@4:usbd: =
xfer_buf_pa=3Dffffba048a026000

Regards
Luca

