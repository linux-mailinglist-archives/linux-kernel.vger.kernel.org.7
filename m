Return-Path: <linux-kernel+bounces-846688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB54BC8BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 980CD3457C5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661E82DECAA;
	Thu,  9 Oct 2025 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCIm7Bma"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19EA2C1597
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008757; cv=none; b=gtZg7zRhz1crkG5UvD+YrydTqbOqhRVef/8VvCJK2g3QekdExx5nV73852JMlZCUMyALo08zafpWdJ3f9RnQ4uul6mv7PdFlD+ptcUwCPGzS7gxH3IjEWkJYtWx8AC28jaS/Ee6MEPnVIC8+NjN1UEKYzkq9XQCCTQgkdTaajsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008757; c=relaxed/simple;
	bh=Er7+0NzPBttzl33dX5K3f+t6LLuZfNrmGEFW+yrPSTs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=vD6HzQsKZZk4O7NkhrNvAYBpyq49MqZNCLohOslgBF7qJJVJM4aC1KFi+i5gUuXdKw/rUrXzxnU5oAac0K1Qm/oHP71KfM+xWp7C48XtUao7DtQgOIJ8dcEnBK023f8UKZPnkWrALVe0VW/MS3s0BMWAuVqWDlssaw/9f4bQ2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCIm7Bma; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-856328df6e1so85577185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760008755; x=1760613555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2+nztQxJYo1fcp2X+/SRek8i5Hcf2liCQ3yDtTdXDp0=;
        b=OCIm7BmaqwxeVVjK5yJ7K3fsPpm6G78bIVoDI4cqCFe/GThV3L1KYk4njpcziFqt9O
         5b7P6thOb4ZtAzi6T4Ps79VLvMh8F7UxTz3LE+viUWfZ1kEAG27RSlv0nSJp4EisWBcQ
         0zbL8sxoR4K2P6Vqh9qt8tKr+KzKevX7UcC1gzVDnNCrHZno6JwDn0p73o9Ap4s78VkO
         9DDAG1j8otEdIhc9Xhp/l0pxhSVaWzq523JrntiZFmKdr2M2iabUy2Wa5mRV9GfWxTGm
         iQTkn1bUeOc5poXYk+p4a/KjoMBu0kr4tBGxDl2O1QxvzoOIp00/S/Q3lwlN3lqHWuo1
         kJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760008755; x=1760613555;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+nztQxJYo1fcp2X+/SRek8i5Hcf2liCQ3yDtTdXDp0=;
        b=uGNbDnchvrQ67lZpVJKleWDl19jJUqwrDQpsF0kOa9UvFLCd5npONn9HcwZf2UZkhj
         fmB8FXNPUeCHbQ8EgcjeefiyMswm2TakGyCqsdSGsG2pQeJf3KtoJKEKTDM2PzqrPM/2
         0lojvKuVVfAu44WkPYfIFArBSKVwqk+8UllN9YInIWz+9+zEbiGg6EtMUIA300EOODI1
         OMB3Rnjw6Z/AE9JTmnSz3ogrxCVu+qdSDnd+qCgN5Y2zMI6ahaRmaW48ks0D25jifgCs
         4B8OjwKJcGS6/rZ35AKyIgVi7OgJtaiSR+uqEEoE32bAZdLXPM+3uf/oo/293gHjhTRU
         OJKQ==
X-Gm-Message-State: AOJu0YySFhD5NIJo7slavbhfK5pQ4tnf18WrZeCvSJf8JMP9rX+xdkdA
	9SOdR46xI8vj3m4B5XPoHZ0PkT2MP5qGdDMxGuxh2rMFZEqtyaceU9z7
X-Gm-Gg: ASbGncuhEMt8umXorMe1dB4u3aNkrsF5o5uGzWhJ6J6q90DITxEFd+Kj1R2jCiemlpk
	nBMTWVFX6wSugWkkugs9Hza9tacPc0vGTRumsfm7tVGvo4glWCvD2w0ixThKRelfc73JXjB8Hbw
	+mtIxbN2vao+Kv+mhhkblfDA8Sb4H4Pz6kphL1DWUg0QaGaHzOLAYnwmonhraA0ZEojj6X7UMeT
	WqOrjkys6cDc/5faLoOZkPcpDS7VpwV99MQoRDzhOwscvuBaRVthUD3dlUsuYCjVr3taYEZQcZK
	aV9WQzLUvDoVmAYvuEQKX11Cl4fb0TGTGhOivJbfOau/jtY7DXXFP4c5gBdRI6MBOV9Q+KLwDhf
	gsPFtupyhlXMkalXAOdOlcMftrlBaIhLoU/aQsi3dr4jntY/6XePsgpex699cT7L+WmF/wOhrYh
	ZyEbR1oMQ9Qmp2hUxlqynyopHC9Qb9rg==
X-Google-Smtp-Source: AGHT+IHihhW/YOXHVyzZUb+FXrQCWCFtSy1W4LPXwnZ7cVYUF5GMmSkXQAaYJZUDTYYTvQXHlr0FCQ==
X-Received: by 2002:a05:620a:19aa:b0:812:cca8:4956 with SMTP id af79cd13be357-883527c91f0mr1055386385a.65.1760008754622;
        Thu, 09 Oct 2025 04:19:14 -0700 (PDT)
Received: from ehlo.thunderbird.net (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f2e00d8sm176269585a.1.2025.10.09.04.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 04:19:14 -0700 (PDT)
Date: Thu, 09 Oct 2025 07:19:11 -0400
From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Lessard?= <jefflessard3@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/5=5D_auxdisplay=3A_linedisp=3A_supp?=
 =?US-ASCII?Q?ort_attribute_attachment_to_auxdisplay_devices?=
User-Agent: Thunderbird for Android
In-Reply-To: <2F525CF9-955C-44CD-A80E-1153BE4CCD04@gmail.com>
References: <20250918121321.116248-1-jefflessard3@gmail.com> <2F525CF9-955C-44CD-A80E-1153BE4CCD04@gmail.com>
Message-ID: <88DC2879-1107-47C1-A713-EDA720BB12E8@gmail.com>
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

I hope this message finds you well=2E I wanted to follow up on this v2
line-display enhancement patch series submitted three weeks ago=2E

Le 26 septembre 2025 10 h 31 min 16 s HAE, "Jean-Fran=C3=A7ois Lessard" <j=
efflessard3@gmail=2Ecom> a =C3=A9crit=C2=A0:
>Le 18 septembre 2025 08 h 13 min 10 s HAE, "Jean-Fran=C3=A7ois Lessard" <=
jefflessard3@gmail=2Ecom> a =C3=A9crit=C2=A0:
>>This series modernizes the auxdisplay line display (linedisp) library to
>>enable seamless integration with auxdisplay parent devices while
>>maintaining backward compatibility=2E
>>
>>The key improvement is adding attach/detach APIs that allow linedisp sys=
fs
>>attributes to be bound directly to their parent auxdisplay devices avoid=
ing
>>child device proliferation and enabling a uniform 7-segment userspace
>>interface across different driver architectures=2E
>>
>>This series introduces attachment infrastructure for linedisp devices=2E
>>The first consumer of this API will be the TM16XX driver series=2E
>>See the related patch series:
>>  auxdisplay: Add TM16xx 7-segment LED matrix display controllers driver
>>
>>Changes include:
>>1=2E Encapsulate container_of() usage with to_linedisp() helper function=
 for
>>   cleaner context retrieval
>>2=2E Improve message display behavior with static padding when message l=
ength
>>   is smaller than display width
>>3=2E Add 'num_chars' read-only attribute for userspace capability discov=
ery
>>4=2E Add attach/detach API for sysfs attributes binding to parent device=
s
>>5=2E Document all linedisp sysfs attributes in ABI documentation
>>
>>All existing linedisp_register() users remain unaffected=2E The new APIs
>>enable drivers like TM16XX to integrate 7-segment functionality within
>>their LED class device hierarchy while providing a uniform 7-segment API=
=2E
>>
>>Thanks to Andy Shevchenko for early feedback and guidance=2E
>>
>>V1 changelog:
>>- Remove should_scroll() check in linedisp_scroll()
>>- Keep attributes sorted alphabetically
>>- Document, invert logic and rename owns_device to direct
>>- Document linedisp_attach()/_register() must be freed by their
>>  respective APIs after use
>>- Change call order of display default message and add attributes
>>  to prevent racy userspace condition
>>- Separate delete_attachment() call from linedisp variable declaration
>>- Document existing attributes separately, in the first patch
>>
>>RFC changelog:
>>- Replace scope_guard() with guard()() for synchronized list operations=
=2E
>>- Replace NULL assignments with proper list_entry_is_head() pattern=2E
>>- Clearly document why introducing the attach/detach APIs=2E
>>- Split in patch series, each patch containing a specific change=2E
>>- Implement static (non-scrolling) display for short messages=2E
>>- Document exisiting and new ABI sysfs attributes=2E
>>
>>Jean-Fran=C3=A7ois Lessard (5):
>>  docs: ABI: auxdisplay: document linedisp library sysfs attributes
>>  auxdisplay: linedisp: encapsulate container_of usage within
>>    to_linedisp
>>  auxdisplay: linedisp: display static message when length <=3D display
>>    size
>>  auxdisplay: linedisp: add num_chars sysfs attribute
>>  auxdisplay: linedisp: support attribute attachment to auxdisplay
>>    devices
>>
>> =2E=2E=2E/ABI/testing/sysfs-auxdisplay-linedisp     |  90 +++++++
>> drivers/auxdisplay/line-display=2Ec             | 240 ++++++++++++++++-=
-
>> drivers/auxdisplay/line-display=2Eh             |   4 +
>> 3 files changed, 312 insertions(+), 22 deletions(-)
>> create mode 100644 Documentation/ABI/testing/sysfs-auxdisplay-linedisp
>>
>
>Hi Andy and Geert,
>
>This is a gentle ping on the v2 line-display enhancement patch series sub=
mitted
>over a week ago=2E I have just submitted v5 of the TM16xx driver series:
>https://lore=2Ekernel=2Eorg/linux-devicetree/20250926141913=2E25919-1-jef=
flessard3@gmail=2Ecom/T/
>
>The TM16xx driver depends on the line-display enhancements for proper
>auxdisplay subsystem integration, as discussed in our previous exchanges=
=2E It
>would be great if we could move forward with both patch series together=
=2E
>

In the v1 submission, Andy mentioned that the changes look good to him but=
 that
he would wait for your review/Acks before proceeding=2E The TM16xx driver =
(v5
recently submitted) depends on these line-display enhancements for proper
auxdisplay subsystem integration=2E

Would you be able to review the v2 series when you have a chance? Your fee=
dback
would be greatly appreciated so we can move both series forward=2E

Thank you for your time and consideration=2E

Best regards,
Jean-Fran=C3=A7ois Lessard

