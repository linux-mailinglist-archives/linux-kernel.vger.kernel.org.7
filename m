Return-Path: <linux-kernel+bounces-787130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C36B371C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFF03A5B60
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FA32F0C4F;
	Tue, 26 Aug 2025 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDsMyEH9"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9782F2910
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230896; cv=none; b=WddTyoiUrPP95pxvOn+sb33wBpYrycEqnlh8IydSC76MBwtmBRcDqNURsMuRW60nOlIlIA0UNXoCukr4/XnTIRAQGId1UKqcX6v0Eo+/oKhpHE2+RtpVTGD0LmGbibL8OtzWoAGe6dFhYVOKhIWJ43IFc4Uj+QpZIHHe82YO34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230896; c=relaxed/simple;
	bh=ADBEEqt/I8SsdIPdL0Z1b4ITRIPJaLgfFIXwhculx/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMKWhGFeHDrBOqGh0E0zei5+H+17y6L+RaS7F9imEQGmgsiC4V5baFdLBHOl1HIFiYH+J5cnYVIO0KEc2aOhf8A0hha086xdQLUa3KlB6nOLDC2WY+VFgu7JZI+OMNabjAuQV8UvW465WLdTk+jugxKfFvqj57FYIGBrx3tetuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDsMyEH9; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109bcceb9so68591271cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756230894; x=1756835694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSb2xeuH5g+6pcK1HzZBzpHptHzZggPfdPMJITj9iKs=;
        b=PDsMyEH95Pio7xl9aCdxsQIaxwBeDXVMDz7AaGxUgFRbT/crn/+1cX9NoTaSTPOcEF
         GS0pq1tKRJOy0nNiYufvVcyYhDxNrIWmmd+65Ob7nl6dLdr5dAFc3xOo3xqYu5Ezt+dM
         nrO7alMnmnP/p5Yx1S02nZABXXcNjcnkhHT0GhvPuvlxQyDWFIi7vX3E2dqBisBTZ2IL
         RhcW4YR2CLog4B+TRlNT4L77P9TW0jvfCUZ4QCIaL0Foe0BUY9bOA1nBU45o3dX19bS+
         LJsgrvCU/ojxNJSpad7XNmBidJVVVGQzOA6X0gDahbD1EYcnssYKZc6SXDADjgj6Svoq
         kmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756230894; x=1756835694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSb2xeuH5g+6pcK1HzZBzpHptHzZggPfdPMJITj9iKs=;
        b=sYx87qTQfGJg2Dr+up5JB8HIs6+nz7mmxbWqsAutVs6ETwzLJEnITuPVr9C0hZstfY
         u1M48+gw4Z0bG3tDn6ZVAUlH48jUUsfPrMGkL47sNyqsN/D6zF7JMMOe2C5IfBrxfT4g
         96Zpv5OrxPfdALjDox8Wx5ukLuh1fjc6OvtoE5fG+EjxGYWHOM+Wk3gIWzScA5zJGiNK
         g5jGjCDwvu1CxFYacyNlppYc1O3glCHptkg7bt+jXwL5v5iiJ1LDmvvu3e4dsTRDpaWL
         R90JsPvbEMRAxpEsoVC1WCRpoyr4qSGfVbyrK/VO7bKPHVP4SLb+pPGOxbCI4U+OwDFi
         PylQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/g3jlfnkmQNn93XYgMoo4visUEUG3FWFMX2dWlUY2iLC1BlWVNBk49Tq/dtnG+vfAZdm+H+TM5BtCDFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDa2YBFk9vgWyI7cNQNWKHMymCW2JTJxylUupoGbnF2Ht4PnS
	nMXEwU1wXDVu/qSDg6ReVKAzWgqE5yZonB4PhRHIXsrtmZIflLbm2+IzJxEm0Kxv8jwgejZu91T
	C60FBOXPiH4jtjQdkoBcW5B5iNEeqzECeuYfUI4Hg
X-Gm-Gg: ASbGnct3QpBAGc7ymZs3HU1xhqNiQPr89+mdJO8YQWwaVRetl6tfhEm64yYtkhTys2R
	qK5e9/H+n56ajNkm+qzpiJdhIh8Mt1q99buCYfWdS1eT9txbBYJau4EhY8idFYfzqSIUD675bWM
	VMdbW1hZnCIAhkTI931n4of6Kz4q5VFxK/H8vS2hwahlFHjNHcHsbHYhDiu3obfY6vdkXcFBcix
	ZS7IBH652dr
X-Google-Smtp-Source: AGHT+IGGV2iyiFmOetInhyxJac4maVVv9fhX96wCprAYO268RITg9RwggZY0uPKZ1PsqeLTeF9F0EJGRkzJfaLhZnes=
X-Received: by 2002:a05:622a:282:b0:4b2:8ac4:ef6d with SMTP id
 d75a77b69052e-4b2aab2be72mr180073441cf.80.1756230892932; Tue, 26 Aug 2025
 10:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756195078.git.zhuyikai1@h-partners.com> <13ffd1d836eb7aa6563ad93bf5fa5196afdf0053.1756195078.git.zhuyikai1@h-partners.com>
In-Reply-To: <13ffd1d836eb7aa6563ad93bf5fa5196afdf0053.1756195078.git.zhuyikai1@h-partners.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Aug 2025 10:54:41 -0700
X-Gm-Features: Ac12FXzidWiTzgg1SRAg60WMCjO05ky3XuED9kyRpFIj1-4hIpt4sOx0xIE9MUY
Message-ID: <CANn89i+D+mmGms5eYxntwpyd3OX1yXz3c9xvjQT_XmmnvxJGwg@mail.gmail.com>
Subject: Re: [PATCH net-next v01 10/12] hinic3: Add Rss function
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, 
	Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, 
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, 
	Shi Jing <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, 
	Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, 
	Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Suman Ghosh <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Joe Damato <jdamato@fastly.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 2:06=E2=80=AFAM Fan Gong <gongfan1@huawei.com> wrot=
e:
>
> Initialize rss functions. Configure rss hash data and HW resources.
>
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---

...

> +static int alloc_rss_resource(struct net_device *netdev)
> +{
> +       struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
> +       static const u8 default_rss_key[L2NIC_RSS_KEY_SIZE] =3D {
> +               0x6d, 0x5a, 0x56, 0xda, 0x25, 0x5b, 0x0e, 0xc2,
> +               0x41, 0x67, 0x25, 0x3d, 0x43, 0xa3, 0x8f, 0xb0,
> +               0xd0, 0xca, 0x2b, 0xcb, 0xae, 0x7b, 0x30, 0xb4,
> +               0x77, 0xcb, 0x2d, 0xa3, 0x80, 0x30, 0xf2, 0x0c,
> +               0x6a, 0x42, 0xb7, 0x3b, 0xbe, 0xac, 0x01, 0xfa};
> +
> +       nic_dev->rss_hkey =3D kzalloc(L2NIC_RSS_KEY_SIZE, GFP_KERNEL);
> +       if (!nic_dev->rss_hkey)
> +               return -ENOMEM;
> +
> +       memcpy(nic_dev->rss_hkey, default_rss_key, L2NIC_RSS_KEY_SIZE);

I think you need to explain why you are not using netdev_rss_key_fill()

