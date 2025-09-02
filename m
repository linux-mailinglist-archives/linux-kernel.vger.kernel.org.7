Return-Path: <linux-kernel+bounces-797099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3106B40BC6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC3A563901
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E4341ADA;
	Tue,  2 Sep 2025 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNx5E+Af"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D4341AC1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833305; cv=none; b=bpmvbuv3JEbip4v9++FBF2k6veFcI3WPOpBMYr08Ay1jiQfE5+dYlNSGl0VcDCOQ6leuv9zLgXSx1c/99YvDmDSWZxKFf617Y/IRwiaJLH/jzz9twLx0p/3m3KPeJaNSVMhRJMItDbgZr6tpQ4QYkaCPQT6QEfSJyUU4iFg/FRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833305; c=relaxed/simple;
	bh=VT+W0iEa1vSHPE3hgaHxG0eNU61RIk5sURkhtwFtg48=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=uH8Flasbkjod5l41/tRFHNmCxdJoxN1uJqyF2NCRDJuPjmR0I8/5jMCq3tkUE3XfmVCSVEurcXzBaROV9mpFz2BI1DXKwm+6xFTlIiMl70mZtwb9ENdtK7d8KK2/QViXur96mMAgceZlWUCpleOL8JyPJVFFccffii2GsUPNU0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNx5E+Af; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b109c59dc9so68079271cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756833303; x=1757438103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7lY77h+5FpOj+4l7+2Fw5/zyBhTkGEwFTa3Qzt1gfMc=;
        b=iNx5E+AfS2OO3WWsq55WIqi7Br4oJbO2Juvnq3X7rPU0OWMIJjX6HXHHw/vWsWAIu7
         Q6vnllByilGgAj5nWz0o+Y0qnTD1eNXMMCZH5Q9R9sHkU2a6jMInkmeiLq84ghLrwaI0
         QQpUIZulqFrHzTGcPIHHWH1ofX7SEs0H2gthgD9Ch5hmkA/ANcTnJsEx15jrknpeZT2k
         9n9saCUxKfgmcQK/yFe9atLdiT9/ku/TfOC3Uid04a3QPU2tuY2LEoZSea3vL5j11DV4
         qriQmp/a5WRXAu8BsT/GAbJQmHoWXRd6Acy1pzU/+WiNii0mKSaOQ+zzGlRHeXftDwVj
         BNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833303; x=1757438103;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lY77h+5FpOj+4l7+2Fw5/zyBhTkGEwFTa3Qzt1gfMc=;
        b=AGJEqWwhq5acjLfDVm16cbcqE6mtMCxT9HHY2wiaiypFHAGZjFuWrTlMee32axG4fJ
         vvuw0zyrbKW3aLWIi0O9xap5MkxmzPdXRlrRwGRIareaWwFSn6VKn/pjLpVxefNfMLMt
         xf6FsF7r/3GBRT5sW/9YD1xRVYaSEXvi/fN64BGVEaBIwCb3BiPSCsQ3CgTX6FnfAZtI
         WlIfd2Fn3B4m6Dt7SAz2x/cdrGqXNUtJbjF7VmpeBNdr4cZWWdi3kpUzTxJx52s+zzhr
         0ZQbFV5/Td2Sj9urmmOOD65CEWWHs6zJBzDx4VqSvVY4x1J6te+hehGV/DvNUhaxa9/4
         /9Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUHOQ+qERsJfpx7JhYonYpcjew/a8wlDxPUIZqVl8CGjylWRrdGD9rvol2e0m1Ml4OWrkF++2TVg3Xilds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxOnjY8vEHKmmiFzKw7CZLocMqlirCqFplpFXPOobeSXigXoQF
	pN6njZCDYXkOmtglRK3RpTvjBPlg0D/x24kVXuuhwN5CzCb6JKdc+oVh
X-Gm-Gg: ASbGnctviWjXJvCSXsUFVSW0obl195iLURHqVmEdk1k7mHhdtbqzJ12GmiVEZiNflqW
	kEVimv0e0uj1fBHm//PyZn1RBYXGp7Jt0ygQwDTRe63oHkKmNPditbkd6pZY2jHhIBp6Ye/Eb2I
	M3kIdGeUSj8OCqC2S5zvVcfwRptWTXC0uLJHkDm7Gg+Ujp23uRNGIBEtz2gyzolJQDlPGeSVSlW
	f+IyTvB2oMVHtp+POMMmZqJO0/pX5/U0fZASHhqavm90FZPgUNLmO1Hb4MfUo9P6fzBSDwJz9B5
	CDaxaT3dogPnuwWC5GWGItekdfMb98yyfZdhRm7mqoI6DfkCxDGU/ocIAMMctAGY4QiJQjG7wRQ
	z+7d70bF1VUQRqMts6ORkiXzMzfytMdgXM3may8bPIm7cbiskx5uSmKsufzp5kxNj2CYc7ipgJT
	QsqH5hMkJEnSG03OTk
X-Google-Smtp-Source: AGHT+IGK0huT1f8aIIAzsk/EJfAZ6vV8pYxk+MgbwpeB6Dlf61ZG0LH/4zs0JI0D20AOmhJNMOQBag==
X-Received: by 2002:a05:622a:18a3:b0:4b0:83f7:b45d with SMTP id d75a77b69052e-4b31d84367cmr144820791cf.7.1756833302830;
        Tue, 02 Sep 2025 10:15:02 -0700 (PDT)
Received: from ehlo.thunderbird.net (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80698060a1dsm167905185a.16.2025.09.02.10.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:15:02 -0700 (PDT)
Date: Tue, 02 Sep 2025 13:15:00 -0400
From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] auxdisplay: linedisp: add num_chars sysfs attribute
User-Agent: Thunderbird for Android
In-Reply-To: <aLbBMumD9mJK2z5U@smile.fi.intel.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com> <20250901020033.60196-4-jefflessard3@gmail.com> <aLbBMumD9mJK2z5U@smile.fi.intel.com>
Message-ID: <F07B991F-5193-4C74-B9F5-B8E62B3000A9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 2 septembre 2025 06 h 04 min 34 s HAE, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> a =C3=A9crit=C2=A0:
>On Sun, Aug 31, 2025 at 10:00:27PM -0400, Jean-Fran=C3=A7ois Lessard wrot=
e:
>> Add a read-only 'num_chars' sysfs attribute to report display digit cou=
nt=2E
>>=20
>> The num_chars attribute provides essential capability information to
>> userspace applications that need to know display dimensions before writ=
ing
>> messages, complementing the existing message and scroll controls=2E
>
>=2E=2E=2E
>
>>  	&dev_attr_message=2Eattr,
>>  	&dev_attr_scroll_step_ms=2Eattr,
>> +	&dev_attr_num_chars=2Eattr,
>>  	&dev_attr_map_seg7=2Eattr,
>>  	&dev_attr_map_seg14=2Eattr,
>
>It looks like we have two groups of the attributes here, can we keep the =
upper
>one sorted? (Put the new attribute one line above?)
>

Acknowledged=2E I will sort the attributes order accordingly=2E


