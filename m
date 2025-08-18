Return-Path: <linux-kernel+bounces-773919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95828B2AC48
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964E716A91B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AA72B9B9;
	Mon, 18 Aug 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=watter.com header.i=@watter.com header.b="K1IvlgK6"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4600E24A05B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529931; cv=none; b=HCynCMGDO3k9ap0yHgU8bup89xFjRM2sCn97h6DzfUEQuRJ37Vv7CkgmhZsIQLnZ3R/eoRCWp3O0lis0rDgud0dNV2+6jJclfy6hzWpk5FNAynVOI03mxCP4rRop5xOBYXyiEijrqBB5Lvj9XbqvkGM1Lj4QAEGR9WxDR0fgY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529931; c=relaxed/simple;
	bh=GOINWpV503zhNSh0S7R/fd//+2YoOn40dCvVN4PqxrA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ab8IS2naBr2p0fl8poH8hp0ikCx6B2ryrp4P+cadpDtlITKrmAMjAW8HzvCCc9BngZy1fkogpKjL6Mjoe94uEYWrGffgZdbiYAKWVkhaRqt8+C6SkhMBNnZG4UG9+DVD9MOBFRx9GTRf+Ww22cabJbpmhFDfXsEXNU9gNCGlIRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=watter.com; dkim=pass (2048-bit key) header.d=watter.com header.i=@watter.com header.b=K1IvlgK6; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=watter.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b134aa13f5so16522801cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=watter.com; s=google; t=1755529929; x=1756134729; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Onn0mFbzSZgX6/mRY4JJJAmbYjWdighwL+n/SYc6vis=;
        b=K1IvlgK6EV376mie6OOe/iE3ZObJu67s3c3nCbuA2jrQfc2LOh24bWUyTaw49h9GfT
         2jGUblTrIJrV/W3q3nKmDa3EvLi+v4HDt1q0AJkbxQrcxOrSCr/ZEgcPCWRRHM5Tok5q
         JYPPMW4IaioVRvpnXpTXZdVJKTcLuv/c44A8jo7fG4Wn9/z4CPbYh9QT17AS5e1PH4Ex
         LVkSr12k6cIjSqFTWTUhpmjD+z1XTHBFkhEQUXXUHR1uEaQ1yde/tE95TRH5TYKfknNm
         03qHsRCn9Q59Hs1e8o5m352HhTMnrogsvuQJp1v0RsoupTeTusxdnU4ziLXiUuROcB/2
         DNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755529929; x=1756134729;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Onn0mFbzSZgX6/mRY4JJJAmbYjWdighwL+n/SYc6vis=;
        b=kaNVpouxycyx/kHHDim2cxMigS6P9W/uQVDxJ+00kVGz0kycGRwgUpr5OGZ+BNfAAY
         veu0fbMszPbeRY+E/2sbzqnX1STe6cO5dSJLB/Fzq0V0IHHndEOJt7zlPlNV00ENruDg
         0dR51msQUkW2cDy80NV9OROp9Mawdnm15OpBgwmGQbHID/cY4oiwQD7DjOHZATi0qcyk
         Llqv41o0rsNzWTNINWrIYTJz3/+btbE8q93caKMH3lrtu/zinFtrSXjzy+bosC0rFAe8
         Uj5havfSTum2FdoTfQVym1ENcfY8pWtINDb9JFZmOGJmXiL9OzwETqrsl0ELT0F76CNb
         wiAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw/mN8qWGm54nLqd664VsUwZZ87sJ19DHLEMqV3tijNg6o/VE06wPCvU5SK6SQapWyNS+0ZQBeRTrz4ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjDq/bOQVFRja6+5p2tiffQziujFWWuzRtXj35ET0LP/jENbEH
	cVxK0tfekhP7YRA2AirSu309+m+0kBolZbOtT3dt47kD1yRbA7S3SjICTWkoP+YGUA==
X-Gm-Gg: ASbGncty9y/pujm+WLdEvdwdCabeo/ORWAJmeNFhGqfo8jG2eeeqcaSlwZIHvS6mEfT
	y1vuiqnqW/vOnqm5MMPs7zV1qFV+/7eFzQv9+YXEsQ0RLLgjkaNyJySQV0t/9O+jZGpy7srN2xz
	x3Tnq5qrrcr++i8VGCabCsNa6Nf6tCZq0/359L38yi78BYMcPnMKeR20ZTL5+YTqFItgL4bl0or
	HrcjmXHdhcHoy5eu6AMXoA22RXjIsbEK0+nvALa6ZRCW0Lh7rV2u7B4dd9DcD1styYPn42n2SYu
	9cfch6mK4UdN6IWzaJpayN1t3Fos/SWXRgSe1V/rN5OA/zVwmuewZudAsV1cGH+LeyVEDxjyPf2
	L75kvM95MYF2qLSBsskfrrepVNaNipeREc0ymdRbqQRn6w8SL1997
X-Google-Smtp-Source: AGHT+IGESdDWGXnHd26as9NY6mAqTBJBwr+tBkUOi+AoCrlKdcJhaufP8wlJwLtxeP0cwINMR5OIQg==
X-Received: by 2002:a05:622a:19a6:b0:4ab:ab85:e54e with SMTP id d75a77b69052e-4b11e0ae8e9mr168672791cf.8.1755529928994;
        Mon, 18 Aug 2025 08:12:08 -0700 (PDT)
Received: from smtpclient.apple ([70.32.192.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de1eaf8sm53354511cf.48.2025.08.18.08.12.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:12:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.2\))
Subject: Re: [PATCH 3/5] iio: mcp9600: Recognize chip id for mcp9601
From: Ben Collins <bcollins@watter.com>
In-Reply-To: <20250818150659.GA2948920@ax162>
Date: Mon, 18 Aug 2025 11:11:57 -0400
Cc: Jonathan Cameron <jic23@kernel.org>,
 kernel test robot <lkp@intel.com>,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <81628282-E80B-46BD-851E-6DCC48CCC953@watter.com>
References: <20250815164627.22002-4-bcollins@watter.com>
 <202508161646.PDl6V4EU-lkp@intel.com> <20250816110243.06fbf7fb@jic23-huawei>
 <20250818150659.GA2948920@ax162>
To: Nathan Chancellor <nathan@kernel.org>
X-Mailer: Apple Mail (2.3864.100.1.1.2)


> On Aug 18, 2025, at 11:06=E2=80=AFAM, Nathan Chancellor =
<nathan@kernel.org> wrote:
>=20
> Hi Jonathan,
>=20
> On Sat, Aug 16, 2025 at 11:02:43AM +0100, Jonathan Cameron wrote:
>> On Sat, 16 Aug 2025 16:46:12 +0800
>> kernel test robot <lkp@intel.com> wrote:
>>=20
>>> Hi Ben,
>>>=20
>>> kernel test robot noticed the following build warnings:
>>>=20
>>> [auto build test WARNING on jic23-iio/togreg]
>>> [also build test WARNING on linus/master v6.17-rc1 next-20250815]
>>> [If your patch is applied to the wrong git tree, kindly drop us a =
note.
>>> And when submitting patch, we suggest to use '--base' as documented =
in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>=20
>>> url:    =
https://github.com/intel-lab-lkp/linux/commits/Ben-Collins/dt-bindings-iio=
-mcp9600-Add-compatible-for-microchip-mcp9601/20250816-005705
>>> base:   =
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
>>> patch link:    =
https://lore.kernel.org/r/20250815164627.22002-4-bcollins%40watter.com
>>> patch subject: [PATCH 3/5] iio: mcp9600: Recognize chip id for =
mcp9601
>>> config: riscv-randconfig-001-20250816 =
(https://download.01.org/0day-ci/archive/20250816/202508161646.PDl6V4EU-lk=
p@intel.com/config)
>>> compiler: clang version 22.0.0git =
(https://github.com/llvm/llvm-project =
93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
>>> reproduce (this is a W=3D1 build): =
(https://download.01.org/0day-ci/archive/20250816/202508161646.PDl6V4EU-lk=
p@intel.com/reproduce)
>>>=20
>>> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: =
https://lore.kernel.org/oe-kbuild-all/202508161646.PDl6V4EU-lkp@intel.com/=

>>>=20
>>> All warnings (new ones prefixed by >>):
>=20
> <trim unrelated -Wnull-pointer-arithmetic>
>=20
>>>>> drivers/iio/temperature/mcp9600.c:440:53: warning: invalid =
conversion specifier '\x0a' [-Wformat-invalid-specifier] =20
>>>     440 |                                 "Expected id %02x, but =
device responded with %02\n",
>>>         |                                                            =
                  ~~~^
>>>   include/linux/dev_printk.h:156:62: note: expanded from macro =
'dev_warn'
>>>     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, =
dev, dev_fmt(fmt), ##__VA_ARGS__)
>>>         |                                                            =
         ^~~
>>>   include/linux/dev_printk.h:19:22: note: expanded from macro =
'dev_fmt'
>>>      19 | #define dev_fmt(fmt) fmt
>>>         |                      ^~~
>>>   include/linux/dev_printk.h:110:16: note: expanded from macro =
'dev_printk_index_wrap'
>>>     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);          =
             \
>>>         |                              ^~~
>>>>> drivers/iio/temperature/mcp9600.c:441:26: warning: data argument =
not used by format string [-Wformat-extra-args] =20
>>>     440 |                                 "Expected id %02x, but =
device responded with %02\n",
>>>         |                                 =
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>     441 |                                  chip_info->chip_id, =
dev_id);
>>>         |                                                      ^
>>>   include/linux/dev_printk.h:156:70: note: expanded from macro =
'dev_warn'
>>>     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, =
dev, dev_fmt(fmt), ##__VA_ARGS__)
>>>         |                                                            =
         ~~~     ^
>>>   include/linux/dev_printk.h:110:23: note: expanded from macro =
'dev_printk_index_wrap'
>>>     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);          =
             \
>>>         |                              ~~~    ^
>>>   drivers/iio/temperature/mcp9600.c:428:22: warning: unused variable =
'ret' [-Wunused-variable]
>>>     428 |         int ch_sel, dev_id, ret;
>>>         |                             ^~~
>>>   10 warnings generated.
>>>=20
>>>=20
>>> vim +/x0a +440 drivers/iio/temperature/mcp9600.c
>>>=20
>>>   422=20
>>>   423 static int mcp9600_probe(struct i2c_client *client)
>>>   424 {
>>>   425 const struct mcp_chip_info *chip_info =3D =
i2c_get_match_data(client);
>>=20
>> Probably a false positive as I don't think we can probe without =
something matching and hence
>> that not being NULL but an error check on that match is still a nice =
to have and should
>> resolve this build warning.  Note there is very little chance a =
compiler could ever figure
>> out if this can be NULL or not so it's a reasonable warning!
>=20
> I am not sure I follow if you are referring to the -Wformat warnings
> above. Isn't it pointing out that the second specifier is missing the
> actual type? Shouldn't it be '%02x' or something of the sort?

That actually was the issue and has already been fixed in follow up.

Thanks=

