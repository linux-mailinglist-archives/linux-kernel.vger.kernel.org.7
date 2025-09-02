Return-Path: <linux-kernel+bounces-797137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDD0B40C52
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B347B11F3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD03322C94;
	Tue,  2 Sep 2025 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvgufOJw"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087772DF15B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834958; cv=none; b=IrrFAI0ETf+JRaKiJkxrKDJh6SjtP+pGa5t+Ab3ilJTaUYyyAVFwTepbJm0yWMHVGZODaCS64zLrrgm9rkaTJFkqkHuWccLg9XTVxYLjtFPUqi2+epOH85/Ev3KoFSIROjLPtJvApBfTQQWVneUHxnxeLDI73hAqQ3IFbEhG8Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834958; c=relaxed/simple;
	bh=YSAuONSCHnf1OeIZxyJU6HvRtWzZfadpwyG+EIMBY2E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sHQnh4hFxP07oruH15jPmHNABiUi8xYzJitlipY2LqUQUe7vL30MQ0GKtbBk08kY/Xr1mKuhQw/j9KvrCC/JQHfgNkgN63WN9CD+/is7AbVNfYO4rI+YcktksznX+IV9Schickvll+daIERrqmoiS1LglcRszTjYOw6HPUgb1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvgufOJw; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b38d4de6d9so3945071cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756834956; x=1757439756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YSAuONSCHnf1OeIZxyJU6HvRtWzZfadpwyG+EIMBY2E=;
        b=AvgufOJwSAoG6nw9fSFkONr6sk6mOmofxt8UtMUJ8Qqj0UTLX5tR31YRXxwVSfMHOz
         +rRAOS484E00mExK+hsUhO7AF+QnVwEvIfq2X2KkFln/wwZNux697YhUdU6Kj4xOIcUZ
         WR/Y3f+vs6eZTdaObNyOKtfTLna5vmmIVTei+Xq8UmiIQQWoUvAtUwMlHEz7ec6ZN5iX
         YUf6yL8s3kfkaDqF/TITmLGR5mOirbc4JQdjE6bnD1VNSi4Xy+XUfK/vhQB/cq2mYVhc
         WNa0YqnLDKkxy/caha+WSu2L1JJmwUa6lMwKkzEjmghwL+yv0uUMNNoaUSrF+5iHVlkL
         g1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756834956; x=1757439756;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSAuONSCHnf1OeIZxyJU6HvRtWzZfadpwyG+EIMBY2E=;
        b=AZLDJoIMut3n3d5vRZk+vANT8FGLjdK0XsfZtZsLMKlKZV/NuV83C6D4eL6hYt9FBG
         3HlVNCLkBsB9Zz+P6vFIu+Z7DySTTJkwlLZn6khNara93TKoAFWjwBdjvyI2eEPLZPc8
         DcawyMhM4QaiQGJVhjhfoSpCD2e97TOlBBkUi14lcosBx5TaHxBlcKQQKWeqT089hoAJ
         Hg9n86DAGcHS8u8w+ceKPgHmrLxSHkL1Rtj+lPhrYh+EgYfPpBUDaHHtt1C8zDlKAErI
         T9Onre5WrFS6seu1gDtv4qC0HpioDQSMru6iU7/urxDBnJB4vqZFAVAa3dgoG6qo0e8a
         eOWg==
X-Forwarded-Encrypted: i=1; AJvYcCUEgqNxb0utw9h9k7R3vQilA5COdbp+Xy58rye++ggwcNUnU1pCVuTYgSD5SejCyhVdxKMvjdIj4+ZhIpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz17n4ZcuzIgsAGD1130eiEDpGYDl2+tms1EBEl4eGWrHVBZdwZ
	BlFmoVDILe/W64VabLMGebWizG0QLVSOEyB6VT5kaKSfbbR3htsnhiBo
X-Gm-Gg: ASbGnctMW3vZxd4ZRTFODi6VkoYsmw8B5C48H5SRRez4kiwaqEDIcfaADGzGVSvB40P
	WvXeqhl6yAROYay4qiS7rIXYAliveV0IAIKHB/lPaWzehPd1GRjF9C0b6QADSnwiuJDglHSOY5I
	WNm0I+7YdfCBxJp/Y/ELoVZVztdMxFf0lnIF31Azhh5jlkZ22YSJfKPmEKVRT2qrJcsrj/VMw7l
	uWl42XFzIox5zBpZNJiulp129Mqp1FzwhrXsb2pPFopvD0ksFRZDxJVopLB4HbTU55H3DOa3QgS
	uZPC5OTr4SuYlf6T/b29YxU4iKJPwL6+MLVpo9y5bVAHPWpN82mPlpFzD1bdnxVbXi+nlt83hde
	9x/2W58fW5yZp6Yl4zf9uuVBchDYaSfGn3xrRu1Ly2dahsLdjXR29cES3S+niw6G6gIFq3jL0/f
	vrS4VTKQ==
X-Google-Smtp-Source: AGHT+IEG2NQqLFWuGp1CIieUH4wkqXPqrZcPhOnSBIsgj3DvL4j+IG6INDOPgcU+lMYLbBKn9X44cQ==
X-Received: by 2002:a05:622a:50b:b0:4b2:e166:7a84 with SMTP id d75a77b69052e-4b31d547b73mr139530961cf.0.1756834955789;
        Tue, 02 Sep 2025 10:42:35 -0700 (PDT)
Received: from ehlo.thunderbird.net (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b3461c420fsm15622451cf.14.2025.09.02.10.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:42:35 -0700 (PDT)
Date: Tue, 02 Sep 2025 13:42:31 -0400
From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_5/5=5D_docs=3A_ABI=3A_auxdisplay=3A_d?=
 =?US-ASCII?Q?ocument_linedisp_library_sysfs_attributes?=
User-Agent: Thunderbird for Android
In-Reply-To: <aLbOGg06ZHkRpDNr@smile.fi.intel.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com> <20250901020033.60196-6-jefflessard3@gmail.com> <aLbOGg06ZHkRpDNr@smile.fi.intel.com>
Message-ID: <582C642B-6E20-4E01-9477-8DE9A134D49B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 2 septembre 2025 06 h 59 min 38 s HAE, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> a =C3=A9crit=C2=A0:
>On Sun, Aug 31, 2025 at 10:00:29PM -0400, Jean-Fran=C3=A7ois Lessard wrot=
e:
>> Add ABI documentation for sysfs attributes provided by the line-display
>> auxdisplay library module=2E These attributes enable text message displ=
ay and
>> configuration on character-based auxdisplay devices=2E
>>=20
>> Documents previously undocumented attributes:
>> - message, scroll_step_ms (introduced in v5=2E16)
>> - map_seg7, map_seg14 (introduced in v6=2E9)
>>=20
>> Documents newly added attribute:
>> - num_chars (targeted for v6=2E18)
>>=20
>> The line-display library is used by multiple auxdisplay drivers and
>> can expose these attributes either on linedisp=2EN child devices or
>> directly on parent auxdisplay devices=2E
>
>Can you split to two? Document undocumented but existing ones (as the fir=
st
>patch in the series) and only add a num_chars when it's implemented?
>

Acknowledged=2E I will document the existing attributes in first patch of =
the
series and then document the new num_chars attribute within the num_chars =
patch
itself=2E


