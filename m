Return-Path: <linux-kernel+bounces-806585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 917D4B498C4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048C3446038
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1AA31C59E;
	Mon,  8 Sep 2025 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI+dNNXU"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075A31C591
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357456; cv=none; b=jzfZ626ZpnG071XVaOLmEHPEsSKrAtJa76whGLautYmPiXUoIN5Qp/XdEoXn3ba5wLBp7QQru2cQmunZF800hVuM0ka9vMEDWkEMz4cb2dHkSXMWllmI7vcRX9ARIw00MUVx56juyztJDIDh5ghgU44wAqzxplLBwEsJeDQDsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357456; c=relaxed/simple;
	bh=2SzqcPkDr1zsoWu2//Gu/hEh9DtcVOnjIsKXK3GDFYc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Z0erEIdROmOzDdSd6JrD/rZXxN5k29vwCPiZmj//U5eY+w7h7MKX779mQVh8A5Q+FpFS+B8tysX+1Umz7PRlJ/FWPwdS4iQ+W1CVI57bVXbSraCPKb0jC+xZHTuUrrxn4QIzzHhvEGzuYHGb4iNF7gjfMzA/Gptinbk4fdCYgaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NI+dNNXU; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-75512f5a75cso1081106d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 11:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357452; x=1757962252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wpjl1VsvnwUrUW9lmJONH5RFtZ15KUtuDWuqeekBKbs=;
        b=NI+dNNXUeRZbVUa91Oa0ux/t5Lhby/RA46MUvVoZNc2973KBKhkD7dMONBrrRBs0L5
         ApHcuBB8WLLjvzUIbHdko1fmtcpbefhoDgfG2kckXrdAlca16FMqFwTYk7tbxortDSZS
         7oWJEu/Oq2cEUlw4kFhPw05nMXtCgBSyZ3tthFXQUbZUGu8zMUzpeQM/UG3eALhouZy/
         Q5XG3YYmKR0crvTtLwxaBIwNB/P4j9pppyY81eKo9qUrFCM1rp+BpoFLCsYHWEGUIUZl
         k3BOxwtcbns9IP7TqrGwBbsxlevBHUb9U5tNo5IYhIYE9oFIGkn0AihxjbGB7Tu00MbL
         oFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357452; x=1757962252;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wpjl1VsvnwUrUW9lmJONH5RFtZ15KUtuDWuqeekBKbs=;
        b=ngsGGZXHLAuLcmY3MIMVWa8oMjJUCB5U30P4uC/nBTVN5C6w4byd5x5PkSMlx5Pi+z
         1FqpkIb5gaBCtKmSPCrCiFaYMU9vpQTbXhQ+aulz2VPtfe8YhgnHcJChG81iDUvpyJF6
         6w+53rYFaLX9vP0OiIL2qx5jdJjd6MeOA0sfDOYv1apC0T0mBdPpQqCnSwwu5siii+Yk
         FVZ6/qR21VXm0W09TxXn1/kFCthpEEbd+9c6Xr8NeEf9Pzj6K1uBAw81D8o8ltTicVq5
         DfknV+jaNktLhI+6zsNBSkjn2ufbEIi2WJrzTrcLZAhrxCMWbyb6PS2zo92A2JKHTeFh
         oJfw==
X-Forwarded-Encrypted: i=1; AJvYcCU954kvKQIVIAHEaFqOQXo16jeWZ4fKsDzcnjRTm5ZyTOfnztzsjRAiXDKahL10et3MzMJj+Ao1prFwhCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsWzuvR6/JE4XZ0oTRoXzEJ3wPPfygpSFJcIP8053Rbjfn6Jux
	vK9UvSHW/Z6LsCyrrCB4fRI5sRG9DhA2Y8eFrcjz+zdcA95jyYI1xTraw/dtZQ==
X-Gm-Gg: ASbGncuZh1QBHG7trl7xyCPQa5HywJ91OY1TckdO632DaR3Kxa5OFLVhn2PwAEDy4r0
	v/BbdkwcPjxNOk4+kBUJur9AndePie2WxS7K1tptyfNoHdrM3Dfur4nTN4iuH0u9UZzoNShHg7K
	4xEtrTNZxOMgyqL7wlfMIOzz4CCtKZRLOfLucQmikVd50JQnS9BaSj8CmUrGTCztW+lEolMJfnE
	b0HGdCRJqWsRyIX/2YKaxV8+FNZKUsV+p6ZJtnUWR3VhLgl45Z5zBIqpkhExpCEfX1c6QGOcUCn
	cs9xL83BEbQicwA+weYJ8njhtu9zquiHRM0T/I44pxhoQ+FwCmAJWOVK67xQAyXUlFCkSFF5BlM
	VGJs+3hmx46Df6sbmK5dQVTJT5lYweedKKOh9dNxunX8Gdml+9oOd0Yf5fLM1F57CgmJnQCR8m3
	Kdephamw==
X-Google-Smtp-Source: AGHT+IEs/9YTlVB0tepEZNQ78rnD1YJ4meB3t0A9WYjNBUdaEIp5+gHzoAWgpUvNXGCsjHpzqyMc5Q==
X-Received: by 2002:ad4:5f07:0:b0:728:4af1:e4f9 with SMTP id 6a1803df08f44-739435cf288mr107437566d6.47.1757357452332;
        Mon, 08 Sep 2025 11:50:52 -0700 (PDT)
Received: from ehlo.thunderbird.net (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ae045ef6sm126136056d6.31.2025.09.08.11.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 11:50:51 -0700 (PDT)
Date: Mon, 08 Sep 2025 14:50:50 -0400
From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Lessard?= <jefflessard3@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/5=5D_auxdisplay=3A_linedisp=3A_suppor?=
 =?US-ASCII?Q?t_attribute_attachment_to_auxdisplay_devices?=
User-Agent: Thunderbird for Android
In-Reply-To: <F8CD496B-97D7-4C69-926F-4137F3006AA1@gmail.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com> <aLbOU0vIXX22uVvf@smile.fi.intel.com> <F8CD496B-97D7-4C69-926F-4137F3006AA1@gmail.com>
Message-ID: <A8F9D18F-7C12-42B3-A9F5-AAEE1AC29C2C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Le 2 septembre 2025 13 h 44 min 45 s HAE, "Jean-Fran=C3=A7ois Lessard" <je=
fflessard3@gmail=2Ecom> a =C3=A9crit=C2=A0:
>Le 2 septembre 2025 07 h 00 min 35 s HAE, Andy Shevchenko <andriy=2Eshevc=
henko@intel=2Ecom> a =C3=A9crit=C2=A0:
>>On Sun, Aug 31, 2025 at 10:00:24PM -0400, Jean-Fran=C3=A7ois Lessard wro=
te:
>>> This series modernizes the auxdisplay line display (linedisp) library =
to
>>> enable seamless integration with auxdisplay parent devices while
>>> maintaining backward compatibility=2E
>>>=20
>>> The key improvement is adding attach/detach APIs that allow linedisp s=
ysfs
>>> attributes to be bound directly to their parent auxdisplay devices avo=
iding
>>> child device proliferation and enabling a uniform 7-segment userspace
>>> interface across different driver architectures=2E
>>>=20
>>> This series introduces attachment infrastructure for linedisp devices=
=2E
>>> The first consumer of this API will be the TM16XX driver series=2E
>>> See the related patch series:
>>>   auxdisplay: Add TM16xx 7-segment LED matrix display controllers driv=
er
>>>=20
>>> Changes include:
>>> 1=2E Encapsulate container_of() usage with to_linedisp() helper functi=
on for
>>>    cleaner context retrieval
>>> 2=2E Improve message display behavior with static padding when message=
 length
>>>    is smaller than display width
>>> 3=2E Add 'num_chars' read-only attribute for userspace capability disc=
overy
>>> 4=2E Add attach/detach API for sysfs attributes binding to parent devi=
ces
>>> 5=2E Document all linedisp sysfs attributes in ABI documentation
>>>=20
>>> All existing linedisp_register() users remain unaffected=2E The new AP=
Is
>>> enable drivers like TM16XX to integrate 7-segment functionality within
>>> their LED class device hierarchy while providing a uniform 7-segment A=
PI=2E
>>>=20
>>> Thanks to Andy Shevchenko for early feedback and guidance=2E
>>
>>Overall LGTM, only one question about spin lock vs=2E mutex=2E The rest =
is simple
>>nit-picks=2E I'll also wait for Geert's review / Acks=2E
>>
>
>Agreed=2E I will wait for Geert's feedback before submitting V2=2E
>

Do you have any feedback on this patch series?
Or would you prefer to review V2 instead?

Thanks in advance,

Jean-Fran=C3=A7ois Lessard


