Return-Path: <linux-kernel+bounces-785914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5813EB3526D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275692416C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960A22D3A9D;
	Tue, 26 Aug 2025 03:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtlT+5lK"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB659460
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756180761; cv=none; b=ku02jUBcG6lh8KKP01QCfmQCDovmlIHtJJ/ZIZTVMErbMODMhsODYAjg119hMOVVkILdb2YS3k8Nz+FWlYkYle0hSTqr4SK5Re778XVXyCLaZCFpqmiOR2g4JYbIqRZy/Q5JDjdtoCcXo6+jzXsiqbkPoiNndD6L8xEJc7g4Whg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756180761; c=relaxed/simple;
	bh=ku5dJ7mWu2FTM7kxUCxraGoy0CLlKBaMMxyPMUwygcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6UycKZyeUomIBnQbk4D4yiLCB2coRB7TnA1lJ7JFrS5UA3Zi7mJPbS140GFbyjTRjnh/7fqkBV76FsEzqiqk6FSWMMZLc8wZjcJmDOI/2tf6Di0NAj0X/Atx91bALsr86LnkHvTVtkejowL8JZyZuWbBxS36Vot5dbaXLS2y9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtlT+5lK; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3edcc634157so108665ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756180758; x=1756785558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo9WnTx9CPiI42N/g6zWrAbo0QVqmrz9KkiX1kCO74s=;
        b=jtlT+5lKN/fDKoQeheJPYvHAVagqyU+JSZvC8lfa6D7sRr5Cqqeu9a5LjvOwrdjH8s
         2yfgwxYpZX49iRa9M2pUHapFlOe7rKA17Xz7HJBpyMSrdukkfvLutbOT+LoPhHFANyHE
         kX6dKvA3BFjb7hnZl7/W8ZjYwZOivFoDoQ45ZvkhezsPR3dQpEjubxBbfn/d0CoSj5Gz
         o6w8+Z8sNVk8HHR3rvC/AwExFmW5Og8p+Ejt3fG3wOt1r+EgDX5ysNvy+rz5efO2eEsy
         BDS2cf15WMgawERpjq122dIcaxYSkjr97fDduGEuEevjjVBlE9GT/G7/gLdKIB7zDbg8
         NH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756180758; x=1756785558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yo9WnTx9CPiI42N/g6zWrAbo0QVqmrz9KkiX1kCO74s=;
        b=or25K+X18rYU6gCTCxFwFN2BTSDZoHqkUbWJgwunmzQB4v47ry+YrB0STEKfULxEsZ
         V9irk0GBVpDXSO581BWAQZ1NqJCdg0ebxj5r5PmbsedgvvWC4U7fbl86jhNTnzBo9YpB
         hEBaVstP36LntRjFTFl2Z/21P0h27dK74b3xeNx7ss+ou5tekRLv1uADpam35v49GEiI
         Yy0mPRia2lh2yThiJfKn5BYzjE6JqAbvggqVEKXVvD6sn8qoJuI2Ymuj01F+L5o+lxz0
         GyEa+Wh7zAIIRa6aNoVA31uB78+kx2RR/vKImIFzRh16MGI8VcOvqHKPj3ka6ZjLYgsa
         HaAw==
X-Forwarded-Encrypted: i=1; AJvYcCWeOq+MxoMC7xWQ35TUA6gVVjF1duc0RvsYHB8LYAphmhaEdxCFP2AUGWCJCCU4m++D8gwSKRScQGJs6zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywja7TtXn6re846yJh4F+7yb5/CnrHZTys4Otx1oLjZJ+5I/dPp
	xAn9OcpOeIe71H4gacGBzLhXSFOnlyvIr6FDNas2ISEayzd7yjEXU/fa1rdYzncBMtenP9aztJF
	SynX3mdqpGbxeJVj3UcnPFpwjFnICqUQ5Qc4o4ANj
X-Gm-Gg: ASbGncv5lr8dhBew788ww5oiHyDi5bE/kCIrPBLQeZ14Xrv5mD6/ofgb+hYvJXZZGh1
	obRLIzjg+D2V22xC4K3CRSW35oDYHrkivsK2DzBpnhutdvR0YM5oX3rxx8pvjrHRpb1bfo1otJG
	AizicyHdlFpQMii4ENEv+QjdCelENfLDmhqTZRPM18JyxvCdy+/Z0JgVv8EozlIhbD7w0X1nzGS
	PNF0tuUQ+oVDnZ/sWsrpuUAFM5cl6CPbL9swcx2DWzqA0IKj6GAVodKxcvDHTwuzTk7RwQoIR6S
	0UXQ6C62
X-Google-Smtp-Source: AGHT+IF1HMxC9ND4cbNs4BiCvmeilneBno3bxqFqiKxWpcNNcNxgC7LaTwMjUts1hDaLIlv9jLrTZ845fGAPRxN//xw=
X-Received: by 2002:a05:6e02:1fce:b0:3ec:a6bb:b116 with SMTP id
 e9e14a558f8ab-3eea3ff77abmr2110145ab.3.1756180758266; Mon, 25 Aug 2025
 20:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801034004.3314737-1-guanyulin@google.com>
 <20250801034004.3314737-3-guanyulin@google.com> <2025081326-guileless-lego-ec59@gregkh>
In-Reply-To: <2025081326-guileless-lego-ec59@gregkh>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Tue, 26 Aug 2025 11:59:00 +0800
X-Gm-Features: Ac12FXyoIUTm8umMVeRWuavw5Mt4DMflONeTo04Ip45unGqnZBeUQSgzyrnb07c
Message-ID: <CAOuDEK3KZHgY7Z2mBOuEhuUn8eLfjS5BPcx3kaMqVYLUhOavWA@mail.gmail.com>
Subject: Re: [PATCH v15 2/4] usb: offload: add apis for offload usage tracking
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, hannelotta@gmail.com, zijun.hu@oss.qualcomm.com, 
	xu.yang_2@nxp.com, stern@rowland.harvard.edu, 
	andriy.shevchenko@linux.intel.com, ben@decadent.org.uk, 
	quic_wcheng@quicinc.com, krzysztof.kozlowski@linaro.org, 
	dh10.jung@samsung.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 10:50=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Fri, Aug 01, 2025 at 03:39:31AM +0000, Guan-Yu Lin wrote:
> > +
> > +config USB_OFFLOAD
> > +     bool "Enable USB offload feature"
>
> I'm confused, we already have a "USB offload feature" that went into the
> last kernel release, why do we need a separate config option for this as
> well?  Shouldn't this code only get built if the drivers that need it
> select it automatically?  Forcing distros to configure this isn't
> generally a good idea if at all possible.
>

Based on the discussion in v13, a new, separate USB configuration
option is required to avoid core USB functions being enabled or
disabled via an xhci-specific option. The USB offload feature involves
a sideband entity that can access xhci resources, which, from the USB
driver's viewpoint, means USB transfers are offloaded to this other
entity. Therefore, the name "USB_OFFLOAD" was chosen to reflect this
functionality.

>
> > +     depends on USB
> > +     depends on USB_XHCI_SIDEBAND_SUSPEND
>
> Especially because all "desktops" do not want this code selected, so
> having it in all distros feels like a waste to me.
>
> thanks,
>
> greg k-h

For the config keywords, we could automatically select USB_OFFLOAD
once USB_XHCI_SIDEBAND_SUSPEND is selected to reduce configuration
efforts.

Regards,
Guan-Yu

