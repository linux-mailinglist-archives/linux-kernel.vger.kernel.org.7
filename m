Return-Path: <linux-kernel+bounces-834226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA5DBA437A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE07562D12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58C91E633C;
	Fri, 26 Sep 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXuuEcxU"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73334BA4D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897080; cv=none; b=nG4mZNvKBgJu6iGd1k7LaHmSzd9IEfb3p9zx4JI5+6QOjsXfsyrQEJGXPBM6p3eoSF+4OOvYaztEgRvLD85HZf++iOvwXTaaY8cpFl2sXtaGE9mKWaJA4pytHW1yTzLEqGs4UzfG7L+CsUbKBZvZmpd3lGPbRJ2GxlgoRXBVpUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897080; c=relaxed/simple;
	bh=ba5Psm1s8FXSXyKJh6ANCALNe0xbsXkA89mXRc9i4Mk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EBtPG9hQIa7HEVmjPzMwPLLEYVh9IjY5KRoWU0QuXVnyuk1JgGSr8yakgJ51RSU7r3hpIJmPFymS/Izp7NZoeFQJgoNhpdG0zWmJWyAJaTu7AlfJdigrBpnv82sQ3S/Y5yYvfjLdE+ZLJxO/Yr8OIO7B2664VPpIIMoXZkLctDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXuuEcxU; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-791fd6bffbaso20958296d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758897078; x=1759501878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u6Lvq4fwEc9t1dKrhO00zQQvWm75RjN2e1moJlDEW2o=;
        b=bXuuEcxUptM3LKz0hG00dlRVJc7fDHYAM0tDDCbB/ED8Lyt5PuLUZP46k5p2cv3otj
         IIDD2zoLZWBHpPaTNONdY8ZTUZ6GZZSFPj5ZUTMDe7OmPAMvPqJ9ZsNC62KScRImvvL+
         CqsfvE7Vx1yrfuvR15dZCoZgLNcYTo0/AoR7FQlZlOEENlu1If1nNFProDt6lCH5VFBd
         zuUyuUKYWjVj3uCNGzXOkbJrFpTIWCrl7Vec+lXIKdbQ0GGkqpD3JNj+EaokAS8DmPrJ
         DZU7vufNtq+v2Qi2lw4e6a+HnL37wureA4/aBxFcoEsafjsS5HWhGsuxa8Wz9LyMQMn9
         roQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758897078; x=1759501878;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6Lvq4fwEc9t1dKrhO00zQQvWm75RjN2e1moJlDEW2o=;
        b=LrftTlAC1EkRZ83Q39Z5Ov1Xinqyp2h7OmfK9972rxXV81fTbvpUmsFjeEda69JgYq
         QM+Zer+tvVkTQs+k4ZEFIbtm0QwBVMXdyP9sSNZRu5fTw+iVMgCCPwmC6vgQ9d7v1Yrz
         iCFD8l8SA90AVH7uHgYwGBhlIz3BXevd9a46Z2ZMAp7ILmZVTAWe37XanLWWiTt3+C68
         6VJJBbd248Ec7t3aDcxh+AI7oECx98/BA+CkxkUSH3pLSb94bBqHC3pcCzqlheojcnUz
         S9oVPXGWfy3EVP7oEGL05Z34343ANjjXKUOiz/7JWTfcU1Xh1uRqueeiUfe/vEjy92iE
         EeDg==
X-Gm-Message-State: AOJu0Yy9MfvifkRAWbd4BsO/347pPHi2nJ71K69EMnQTra+lSpzMgWOe
	ZwsHwi+4zZctjf9ukKt2YyIhUNVA+4t+VL8/Ca/fDnDCzlrbF/5W5N/1Fab7VgtG
X-Gm-Gg: ASbGncsVqy43yQEbYPfpl4fWG+MUZqiGtHlIqSfdor/lZdoSsvtdiCsUZeA0wWVONjD
	edfiejO2U/VJ6g836VfsIAlOMrZWJiNLYtqtJqlgrKdKfeyw40fFLwHPWxwjE9oJgRYHDSh+i0E
	tY2H3goZVpYVfsd38bdM2DIVMOxMkQpOL99XGPpq8U1s4vDTJHqiRm1YZQiL5rLJlf5xVW0G8s+
	IZfpj9vzZBxs91mZ75f02rmyfluTeBRJMTPzUxwO2i0HH0HgO/Pb60Bb42f2UtZ5MhEnF+VlXGE
	fXBLRRbSwzfNyDjxyooAvC0gMOdK6dl+zRh89lAHX7n1cDo/lkxUacwpTC/iBJ0YlMUMRQ616tF
	6LDo/yu/xrVqzhFHGVVxrLO2X5l9rNXMlZuXJpXSsfWMbV/2akXwDH3dU5vMjFRgrYcTpkxHwyN
	YPMVznOar8xhgUht/t
X-Google-Smtp-Source: AGHT+IFNQ9ERkRQJ/XxzNZ2JM+RQh6czbf2sgvsw2cdz4Jgki6nWZkBbXv7jQKDy2eWMv8JHx1Ds2Q==
X-Received: by 2002:ad4:5ba8:0:b0:7ad:476d:97fb with SMTP id 6a1803df08f44-7fc2f4c51b3mr116448216d6.29.1758897077695;
        Fri, 26 Sep 2025 07:31:17 -0700 (PDT)
Received: from ehlo.thunderbird.net (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-801667815bbsm27480596d6.40.2025.09.26.07.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 07:31:17 -0700 (PDT)
Date: Fri, 26 Sep 2025 10:31:16 -0400
From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/5=5D_auxdisplay=3A_linedisp=3A_supp?=
 =?US-ASCII?Q?ort_attribute_attachment_to_auxdisplay_devices?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250918121321.116248-1-jefflessard3@gmail.com>
References: <20250918121321.116248-1-jefflessard3@gmail.com>
Message-ID: <2F525CF9-955C-44CD-A80E-1153BE4CCD04@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 18 septembre 2025 08 h 13 min 10 s HAE, "Jean-Fran=C3=A7ois Lessard" <je=
fflessard3@gmail=2Ecom> a =C3=A9crit=C2=A0:
>This series modernizes the auxdisplay line display (linedisp) library to
>enable seamless integration with auxdisplay parent devices while
>maintaining backward compatibility=2E
>
>The key improvement is adding attach/detach APIs that allow linedisp sysf=
s
>attributes to be bound directly to their parent auxdisplay devices avoidi=
ng
>child device proliferation and enabling a uniform 7-segment userspace
>interface across different driver architectures=2E
>
>This series introduces attachment infrastructure for linedisp devices=2E
>The first consumer of this API will be the TM16XX driver series=2E
>See the related patch series:
>  auxdisplay: Add TM16xx 7-segment LED matrix display controllers driver
>
>Changes include:
>1=2E Encapsulate container_of() usage with to_linedisp() helper function =
for
>   cleaner context retrieval
>2=2E Improve message display behavior with static padding when message le=
ngth
>   is smaller than display width
>3=2E Add 'num_chars' read-only attribute for userspace capability discove=
ry
>4=2E Add attach/detach API for sysfs attributes binding to parent devices
>5=2E Document all linedisp sysfs attributes in ABI documentation
>
>All existing linedisp_register() users remain unaffected=2E The new APIs
>enable drivers like TM16XX to integrate 7-segment functionality within
>their LED class device hierarchy while providing a uniform 7-segment API=
=2E
>
>Thanks to Andy Shevchenko for early feedback and guidance=2E
>
>V1 changelog:
>- Remove should_scroll() check in linedisp_scroll()
>- Keep attributes sorted alphabetically
>- Document, invert logic and rename owns_device to direct
>- Document linedisp_attach()/_register() must be freed by their
>  respective APIs after use
>- Change call order of display default message and add attributes
>  to prevent racy userspace condition
>- Separate delete_attachment() call from linedisp variable declaration
>- Document existing attributes separately, in the first patch
>
>RFC changelog:
>- Replace scope_guard() with guard()() for synchronized list operations=
=2E
>- Replace NULL assignments with proper list_entry_is_head() pattern=2E
>- Clearly document why introducing the attach/detach APIs=2E
>- Split in patch series, each patch containing a specific change=2E
>- Implement static (non-scrolling) display for short messages=2E
>- Document exisiting and new ABI sysfs attributes=2E
>
>Jean-Fran=C3=A7ois Lessard (5):
>  docs: ABI: auxdisplay: document linedisp library sysfs attributes
>  auxdisplay: linedisp: encapsulate container_of usage within
>    to_linedisp
>  auxdisplay: linedisp: display static message when length <=3D display
>    size
>  auxdisplay: linedisp: add num_chars sysfs attribute
>  auxdisplay: linedisp: support attribute attachment to auxdisplay
>    devices
>
> =2E=2E=2E/ABI/testing/sysfs-auxdisplay-linedisp     |  90 +++++++
> drivers/auxdisplay/line-display=2Ec             | 240 ++++++++++++++++--
> drivers/auxdisplay/line-display=2Eh             |   4 +
> 3 files changed, 312 insertions(+), 22 deletions(-)
> create mode 100644 Documentation/ABI/testing/sysfs-auxdisplay-linedisp
>

Hi Andy and Geert,

This is a gentle ping on the v2 line-display enhancement patch series subm=
itted
over a week ago=2E I have just submitted v5 of the TM16xx driver series:
https://lore=2Ekernel=2Eorg/linux-devicetree/20250926141913=2E25919-1-jeff=
lessard3@gmail=2Ecom/T/

The TM16xx driver depends on the line-display enhancements for proper
auxdisplay subsystem integration, as discussed in our previous exchanges=
=2E It
would be great if we could move forward with both patch series together=2E

Thanks in advance for your time and consideration=2E

Best regards,
Jean-Fran=C3=A7ois Lessard

