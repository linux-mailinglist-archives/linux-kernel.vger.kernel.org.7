Return-Path: <linux-kernel+bounces-797140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F03BB40C5A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268533A3BD5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D33234572C;
	Tue,  2 Sep 2025 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP4glhIQ"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4F322C94
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835091; cv=none; b=XegKInM4uHIlQS3ON8pAr1Od80ShbVopD2NXkZGAr4jML6ZG22M68CBypMhvP1IL5b8NkCpn9RJFEz7uA0IhHb6Y5yxWqbYK3D4BCtG6c7t/HASl5GRVMgOnQlQMjdACWr2qlNLLFXs+6C8QrNszvBGftx8J2/2TisKkz5WbBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835091; c=relaxed/simple;
	bh=4p+SYwTMuGyjE5Jm8vqpnPOtwUU1ClgL2vdd6PLsd6E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=W09R1/WIJQXR19Jj+tLZwHCN1WU+W5LElQQvF/69Q7hmbrTi3pL+2RpTLQQh9d1M/eFqv8umQosxqZ0W6QuSioLsTtUqBwAXxRXyeOIgvVjgYiMBWbuw6498LebUqbd0rkejE5foHolQj8XnZcdK1750jQvio1BQ094ReLStTWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GP4glhIQ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e87061a6d5so565469685a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756835088; x=1757439888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KOZH+zZc04Oudznhvw3WepIdp0UxaguANn3QSwQ8g+U=;
        b=GP4glhIQP1/X7ulhMc333RNURJGP+ipcGtWq6a2oEN/qFmMO60psMW/avX5aNhu2Hq
         XUw1UQS/dIRq3FEWlp9zW83dHrQK3tZ9rZOOWWJWTRtKLcV8U8uFIqEk7p1JDmm9+25h
         FbKJ1pniacrenAcnVi78v6QuqF5c++Jwh+GFMX9tIV/4MBkqrdWzhQobeIUQGpEtbwPm
         kR7or28YRXJIaqMUEdMq3fXfsJ1q9NzcJaK4f0HyWVHhmdP1TbFPhFAxAVNZb80T/qD0
         2cZsNAcETNsnPYifNQf9fTfTUzkWMjgsqCNHpOl1LnA3bAzH0aE1C5tGq/tiDmT37I/j
         toww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835088; x=1757439888;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOZH+zZc04Oudznhvw3WepIdp0UxaguANn3QSwQ8g+U=;
        b=Y4c+Jw8FQ/hSMBnpbLpOF+qLdH7/ZtkMlMeOn7Tk07nKhPlPUJRUS1YnHleBOkqg3r
         rqVdFtyJiA1Fb8GBrtOseXIhtelLw8c+Z74+QprhLa1wgb94OdxigM7n4Xdt1dYp6m9I
         U+JwMC5gBoloYFn4AmwEUOg9qmnxEx/B1yWGN9sNV3E3Jw5EfMVzM4kfrCMomERcKRyx
         3MJEUnxgA0be/yMGZl+/GTgjGvIXfBh7GmdUE7Gj1NSQJNQPm/DGtkXYoVZbqnBJHV0N
         BtjhTxRF6ggnW3oc6GKczeUoRLA4zosLMT+ax3cVoczfNurxe6JUCNRWHQG8NOg+m+FM
         Ax/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWs0DUNTbHSYhNnMBnL2OSYslqvT/k8vMF+qRk/EWhqHyxvf+DzPhwSXgldLhEBv1nRb0efvnD3LH9U1R8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOQqKKqxg/GWAkiSeWesU4EUtTFu2KiGtyD3p5aD0h1qGgoru
	1CfAt7dnFGsVu4oPjja1no/RWNbv5X954fLfPSuPz1snxkFa0fw5ORGBkLTsJgHX
X-Gm-Gg: ASbGnctubBDq6UHYmIREiHiZcQCEesWSW6XIZZa3D6gUc1KszaCLWvGREHqiB+l8Cwd
	6YtaUIZgaJ3dC27YbVP2HvQaotIPxMXT6davj1JewGXC4cghG/Wg2NIXQrMSPcUuZxoXbE9JCmj
	dIkx7Ef54Y/vsmk/oRLoPNh7oYFengr6R/fxmCkDGMl9Brn94CKo5wvBrMlmmVuJACLbPYMSCiz
	xOLRRifm41jywJq8hXeHk53GKBlsSCXyN0k5YldkRNZvpTtrubGgEBaYpjbSaq9rADWDKx14JVE
	6WLDPh3fmoUy1+bz41FjhN8plPsywMQNF2SIk5a5Oo+0PkqTpMGNGU7GF8o+xrDKB4SjzhG2UfH
	XQI5otWN8zq3e0VAkHSwqaIaTXPA2ALmi2+ir2QajPejJiCL6UijAvYnjnvXnad5jzP3mEFFTw6
	3Y1Qikpg==
X-Google-Smtp-Source: AGHT+IGL1Fi6vCAezcJwnwZQDXk5i48PPFUHg1POsV89+pP4u9D+XC2uqR+nrrYLVC3f+pyj5wMJEA==
X-Received: by 2002:a05:620a:4442:b0:7e7:bf9a:8556 with SMTP id af79cd13be357-7ff2b97c48dmr1584000785a.40.1756835088146;
        Tue, 02 Sep 2025 10:44:48 -0700 (PDT)
Received: from ehlo.thunderbird.net (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8069d6b1ff7sm173341885a.69.2025.09.02.10.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:44:47 -0700 (PDT)
Date: Tue, 02 Sep 2025 13:44:45 -0400
From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/5=5D_auxdisplay=3A_linedisp=3A_suppor?=
 =?US-ASCII?Q?t_attribute_attachment_to_auxdisplay_devices?=
User-Agent: Thunderbird for Android
In-Reply-To: <aLbOU0vIXX22uVvf@smile.fi.intel.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com> <aLbOU0vIXX22uVvf@smile.fi.intel.com>
Message-ID: <F8CD496B-97D7-4C69-926F-4137F3006AA1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 2 septembre 2025 07 h 00 min 35 s HAE, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> a =C3=A9crit=C2=A0:
>On Sun, Aug 31, 2025 at 10:00:24PM -0400, Jean-Fran=C3=A7ois Lessard wrot=
e:
>> This series modernizes the auxdisplay line display (linedisp) library t=
o
>> enable seamless integration with auxdisplay parent devices while
>> maintaining backward compatibility=2E
>>=20
>> The key improvement is adding attach/detach APIs that allow linedisp sy=
sfs
>> attributes to be bound directly to their parent auxdisplay devices avoi=
ding
>> child device proliferation and enabling a uniform 7-segment userspace
>> interface across different driver architectures=2E
>>=20
>> This series introduces attachment infrastructure for linedisp devices=
=2E
>> The first consumer of this API will be the TM16XX driver series=2E
>> See the related patch series:
>>   auxdisplay: Add TM16xx 7-segment LED matrix display controllers drive=
r
>>=20
>> Changes include:
>> 1=2E Encapsulate container_of() usage with to_linedisp() helper functio=
n for
>>    cleaner context retrieval
>> 2=2E Improve message display behavior with static padding when message =
length
>>    is smaller than display width
>> 3=2E Add 'num_chars' read-only attribute for userspace capability disco=
very
>> 4=2E Add attach/detach API for sysfs attributes binding to parent devic=
es
>> 5=2E Document all linedisp sysfs attributes in ABI documentation
>>=20
>> All existing linedisp_register() users remain unaffected=2E The new API=
s
>> enable drivers like TM16XX to integrate 7-segment functionality within
>> their LED class device hierarchy while providing a uniform 7-segment AP=
I=2E
>>=20
>> Thanks to Andy Shevchenko for early feedback and guidance=2E
>
>Overall LGTM, only one question about spin lock vs=2E mutex=2E The rest i=
s simple
>nit-picks=2E I'll also wait for Geert's review / Acks=2E
>

Agreed=2E I will wait for Geert's feedback before submitting V2=2E


