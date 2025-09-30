Return-Path: <linux-kernel+bounces-837284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F918BABDC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2544E4E244A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0592BE62C;
	Tue, 30 Sep 2025 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYi+2qIl"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA941DD0EF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218018; cv=none; b=B1nDsFocHOloJYPshtWzW1ZvRU6HFQo8e27Rj0Q3RABxWp0u8nxlCcXbYSDVc/IZIDznWnXAtSFSJBHk3fnCpR9W3zOZTGckSNViRDb0pCVnEik6haaKnDVI4Wv3Xj04evjCWrXh2PlBerhATNseBBRvLkEax+lxm9fpdx6/s8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218018; c=relaxed/simple;
	bh=RQStAXms5PMQwIh67MWVNS7gPGZ4vTX1Si3lGe1kHFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+X9BGEEeCxbx+Kd+obTvfxv3W3mAtweTw92P9k6ysKrOkRVzYkeOQN6WKZW+f/U5Pe0b2p7agLjYJrkQa1Tg0Z8UkAwrz/s9YqzRxKOPQcRrLkCSNUFVywfPBAZf/G1qfQZvzKl4PgrIgYl6UWsjnrlOt3K790THtfqAg2fFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYi+2qIl; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso5926558a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759218015; x=1759822815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zts8pP3+onz4l4ujVG25vTzO1B/t+AvQHBOavBB3fNY=;
        b=MYi+2qIltQQ3kY+TJ1CwAGh1U4b5/B8E9/uYRr9VRq9A7pzIK7mn48uO0c7TSvLBJW
         +6XI7uWdnCu7Ir0QVMZewxgg62NvNAMSxh1mLnfEycr1vBJz0X4YvWmFjZgaeEpsbDFM
         Ljg1xlfnGVMrR0mvmt8hHACYTVMm0B5xQgLij01eLK7Xlm06mA/GRX/uw/X2DNLwl51s
         ByJo0VXp9kVF5awbuA8vCWGwnZn7iEVxMo9zdhGuM5Vjh+DcwXr85PjwILdPqlcjYlgI
         7hi6YoZF63erR6a35mywQfA1SLf9Mayt9yvGjDH9YQGUUl+XGLBTEjb265sDZALDAXTI
         4F+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218015; x=1759822815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zts8pP3+onz4l4ujVG25vTzO1B/t+AvQHBOavBB3fNY=;
        b=MKSt8elgxzRxxni8c/xvsB5gW7aKVKUs4Phlm9rlodPccYhXPoZhNXDatg7bT48HDQ
         QUNRbt0/J5Zi8g7hsVJDtInUFgg+2vTY5K+OY29IcghZQ+0my0KgLxynkcMPI5ckSyFN
         RGagBz3p8s0F3AfDJeDLURNd7AWw4kXKrJDhPnKPsV76FrDXzm2IAtcHy73O+9HkCCB3
         cY/LQ3XdzY79pEzL1zHXGT5j0vz0D9ynyeFK0tc9ZKG8nGyv1+YTdJuGsB5igVu7VAvM
         mW9ja84tjRx48QafMrN+GGdhjVSbvcTO4CzS6YkIYqZm0XhcP/WcSl65k7jvdDvSMEsk
         9+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjdo0hO+pYKRjUEUGWeZMm5iafRmRKJOTTGRZEuT9nKSLFa6a0RbdlmANff+wk4bfxebeX595XFFd4kfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpdx2uS6eut9vPWK4yTVfM/yFPDy4K8b44lJ05+16885IYj5d6
	JkKUVpKhjILuISgJaOjZC6Q2p6Olm3UCizP+tbTYh/KvB96vJvSj/w0mzXCdKxfKP5e+C0I/Zlq
	4+BJFbsSWWCzUC9GEJJiCzMNQHizSpWQ/Namr
X-Gm-Gg: ASbGncv/yLeLE/ReTYSrW4GV0JdNO20B6LngmLss+mhAikDLeuKP/Yl5mb7cvWUUg6F
	T3l7qnxxmWGhoLQHk+dFGV6011vj2sfVaeDChMHeNCSNmOMya6FVHQgXMGgwyFrPBPYNm/upLRD
	qg1EZWHcXjy/IPy2cUL9ajgjXTUaUGdYVf2g092tZO/QolwqRd79ENfhX0Yx44cKcgXss5vYUJ3
	uSdjSEQM677Bp+CrVbLvmWSu9w9s2QJm4HIhbQaXqYXoVIs4Snv288gzEsnOtGwmmi863KjfN4T
	jA1h8uVshi4zXVZLK8Treq4mfUAPoudOHS1ORhJD
X-Google-Smtp-Source: AGHT+IGTKvI1EgmI28isilggVYUZEfP9D1exg1i1hZh7lxCHqd4NwUf7Iw2r8P4SP93LS7emxZAU+m2Q+gXol5mg9ug=
X-Received: by 2002:a17:90b:4a47:b0:32e:87fa:d975 with SMTP id
 98e67ed59e1d1-3342a2c6b13mr20660800a91.34.1759218014942; Tue, 30 Sep 2025
 00:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407075400.1113177-1-linchengming884@gmail.com>
 <20250407075400.1113177-2-linchengming884@gmail.com> <d98f6eee-d5f7-43b7-bbc8-d6e7e274723a@roeck-us.net>
 <mafs05xh6pf7s.fsf@kernel.org> <da58fc81-3c99-4951-85bc-e3c139283b5a@roeck-us.net>
 <a2a0c40e-69d7-4408-add2-88616c92b0ca@roeck-us.net> <aa2a4480-9b78-4ed9-8f9d-b18a87eb01e9@linaro.org>
 <CAAyq3SYybDgBvkTKh2ZB4UdKq1XV_nnzx3Tj1P915W5x_7_nNA@mail.gmail.com> <DD10QMSJVZ2K.26U45JAXV5EY7@kernel.org>
In-Reply-To: <DD10QMSJVZ2K.26U45JAXV5EY7@kernel.org>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Tue, 30 Sep 2025 15:36:40 +0800
X-Gm-Features: AS18NWApi5FotxUWGvIY8CxdHG_LR6-afREmMqbnGO-NfNuET8VB41hFCUTvJNQ
Message-ID: <CAAyq3SYyqi-oR8T039Zd0uaF6UieX3SdF9UF2kxOG6+yJqAEUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: macronix: Drop the redundant flash
 info fields
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Guenter Roeck <linux@roeck-us.net>, 
	Pratyush Yadav <pratyush@kernel.org>, Cheng Ming Lin <chengminglin@mxic.com.tw>, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	alvinzhou@mxic.com.tw, leoyu@mxic.com.tw, 
	Maarten Zanders <maarten@zanders.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

Michael Walle <mwalle@kernel.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=8824=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:11=E5=AF=AB=E9=81=93=EF=BC=9A
>
> > The root cause of this problem lies in the failure of parsing the SFDP
> > data for the flash, rather than an issue with the patch itself. I belie=
ve
> > we should not revert this patch.
>
> I disagree. There are Macronix flashes with that ID which doesn't
> have SFDP.  And this patch is dropping support for them. See also
> [1]. Now I'm not sure it is worth reverting this commit. Nobody,
> except Guenter complained, but only *so far* (and that patch is in
> since 6.16). Any opinions?

I agree with reverting this patch. When I initially verified it, the
devices I had on hand all supported SFDP, so I did not catch this issue.
After checking again, I confirm that some older flashes without SFDP are
indeed affected.

Would it make sense to only change the `.name` field to use a comment,
while keeping the rest as is? That way we can still support flashes that
may not provide SFDP.

>
> -michael
>
> [1] https://lore.kernel.org/r/DD10GE4EOCD7.CPTN7198QFUV@kernel.org/

Thanks,
Cheng Ming Lin

