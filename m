Return-Path: <linux-kernel+bounces-787651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA2BB3792C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC3A36498E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DDF2D24A2;
	Wed, 27 Aug 2025 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOW4ztdf"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A25277C81;
	Wed, 27 Aug 2025 04:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756269160; cv=none; b=bCu8WeqGUpuFOONhnMR31666qUGEAr/2o1jAvY/eLZr49nyMAi2Q045oOeXd6/F3G/1bOC1Y8CTeN/gvdIHomY9oA6lsR34C4VemqE//T0C1wnUTXf/oTlkzCVRIRZ9CP8geDIdPKkjLhISYxVlDmPxB0YBR09CMeI1EIE24TDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756269160; c=relaxed/simple;
	bh=wLfoNCHQ065c+E5KCkrQ+BEavCx+WUP32Ro2DHf9B2w=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sC/VMZB6CtOOu49h8+QN/h/QJwBXXQuGHO2nXvYyLPbYx5LyMBAABtWuzAqAFDjGkQtWgPNsgJqLPm/9e5wcKOD3fbUNlwlgXNraXxOscQ26TNHefQJlSuh0UNR9VNhRH8Eml9f3LBFGnV/cAojHbjv8oCZHhUWe9gpz5xQ7m0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOW4ztdf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso5571290b3a.1;
        Tue, 26 Aug 2025 21:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756269159; x=1756873959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLfoNCHQ065c+E5KCkrQ+BEavCx+WUP32Ro2DHf9B2w=;
        b=MOW4ztdfvBG8Bhd1aEIwsDZF+BQGloMmKNHtjEY69N5v4+PY85UMDloSVmxCxsQ+gS
         RDJDN95WHDZkjwnhUV4VahsnNVEYR3zgJ2CufWOfhXhepLYshgU+fUISKoe2EYR19A/t
         QddYDJDjRq43PyFf55SWyaHolhLoNypEnyZo4iMAbIX3lWCDxwF1nqbuPrTpGHJPZ1F4
         WJv8Hw+TPEE4yFQPUYGpKio5S2CHhjYibAopM9DFmNRlMzJoTu8wmcNYhRN0im5gVby2
         42x0NmCHqfBxxn1JkoktwHrR5/MqdaFZfAXz1uj+0b2m+gTzEWMqHS+kVX/dAYvVD+Iz
         Nb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756269159; x=1756873959;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wLfoNCHQ065c+E5KCkrQ+BEavCx+WUP32Ro2DHf9B2w=;
        b=skpAUtYYVKCNBYNHj9m0/lhZGYLG9ngvDfsZ4zCUuld65df6Tu+9xRpT1aoUJsiagF
         nt3yu7McY/0hnYsT0ce5ZctXJ+QnVDxV82Z+wyQueqk+bJhUx7Ii7xgeTbwJnSQKfJJ1
         /NJ/oQmQUVWVqSLBZ6K3pjIP4c/axUyf/MOuxa4L5HRxVZqIvASCmiWe+CNWFtIPdDfT
         xp5flZL1Qo0yM7dx/i+J4QLBQc5bBnBPh07aRANKAcQOQTVnyoeH84gO2tKRnLIVO9Jw
         No2CCADEE08xhkKKhWWwbNeiWm0S07hcNM6x6Q9WLvAUJnm8NtHYCJZiN2thiZooSTal
         ZvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU307/547TPDQFUjeJ7z6m7jUmWRYGQLhachXiR1tCaAAnjxXh7A3lEDqmmxPJryRuG45ggO5teU//2dhA=@vger.kernel.org, AJvYcCUyaRt3kN4104a95hG4as5h6Q820lhLV+OecqiSZCOR6TQjCpIWdMPEDcWc5HIzad0SSNVnQW/jJWuJAhuVDmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlM/FJifsIBuaW2el1TsbHhQF04mX6YrdbeaphlhzsS9wP5W5K
	KS1IeLcjnksNTFfIU2WAnE7fm/jZ/GolvG2NSYrjONG1XcLb2XmqUcWm
X-Gm-Gg: ASbGncuULRM5JDlRWEhK6KJ+z2TKdP+a5HgGGyjXq9LsNlPdtdWS6W4WNPFR6q5QqT6
	WZhLHV96w87dUNVtEfZYZRIteN7U/dgm0sANbKLaUaUVJW/w5tJSJ0yCkcPqSB8vWIcGYrR+YfM
	BUYah9kKCwgYkRNKPkfJP/nnQ5MC8fcibncpzxieIhTA98nAy5QlODO7//VTL0RFLCZr+YT01/1
	m5XwNdhKCUrLoEUnJz3zHv8yOFN2p6jJvuxLAUsJWsDoHKShQQD7Gxb1cC32nX/8Fy1YfrxcPU0
	9AlNT6lJ8WE3FVpMiVF46gOntIxF7ojckSerEqbmhuIgxNIGOanr5aT0ZshhAJFmTOgMhx+xiBA
	Eou+K4Rq0gxcXDd3FYTbQvitaLwk2lNLo87SuPTMZacUe95fZ5iJLBumntMudvIemZn1TDHvJ5w
	H/
X-Google-Smtp-Source: AGHT+IG6HNsdYadtNr45WiB26DRF77FzbloROp3qetHYX8fk/Hbkl3188y+tLhYXfggD6GzvWCH6hg==
X-Received: by 2002:a05:6a20:a985:b0:243:9d79:d88a with SMTP id adf61e73a8af0-2439d79da49mr1277794637.20.1756269158586;
        Tue, 26 Aug 2025 21:32:38 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e814cbccsm6485423b3a.35.2025.08.26.21.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 21:32:37 -0700 (PDT)
Date: Wed, 27 Aug 2025 13:32:22 +0900 (JST)
Message-Id: <20250827.133222.2149987174177655942.fujita.tomonori@gmail.com>
To: daniel.almeida@collabora.com
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, ojeda@kernel.org,
 aliceryhl@google.com, anna-maria@linutronix.de, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, dakr@kernel.org, frederic@kernel.org,
 gary@garyguo.net, jstultz@google.com, linux-kernel@vger.kernel.org,
 lossin@kernel.org, lyude@redhat.com, rust-for-linux@vger.kernel.org,
 sboyd@kernel.org, tglx@linutronix.de, tmgross@umich.edu,
 acourbot@nvidia.com
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout_atomic function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250827.093559.1495790445785541454.fujita.tomonori@gmail.com>
References: <20250821035710.3692455-3-fujita.tomonori@gmail.com>
	<5C851069-5E1E-4DE9-9E1F-0DF2C86C266C@collabora.com>
	<20250827.093559.1495790445785541454.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64

T24gV2VkLCAyNyBBdWcgMjAyNSAwOTozNTo1OSArMDkwMCAoSlNUKQ0KRlVKSVRBIFRvbW9ub3Jp
IDxmdWppdGEudG9tb25vcmlAZ21haWwuY29tPiB3cm90ZToNCg0KPj4+ICtwdWIgZm4gcmVhZF9w
b2xsX3RpbWVvdXRfYXRvbWljPE9wLCBDb25kLCBUPigNCj4+PiArICAgIG11dCBvcDogT3AsDQo+
Pj4gKyAgICBtdXQgY29uZDogQ29uZCwNCj4+PiArICAgIGRlbGF5X2RlbHRhOiBEZWx0YSwNCj4+
PiArICAgIHRpbWVvdXRfZGVsdGE6IERlbHRhLA0KPj4+ICspIC0+IFJlc3VsdDxUPg0KPj4+ICt3
aGVyZQ0KPj4+ICsgICAgT3A6IEZuTXV0KCkgLT4gUmVzdWx0PFQ+LA0KPj4+ICsgICAgQ29uZDog
Rm5NdXQoJlQpIC0+IGJvb2wsDQo+Pj4gK3sNCj4+PiArICAgIGxldCBtdXQgbGVmdF9ucyA9IHRp
bWVvdXRfZGVsdGEuYXNfbmFub3MoKTsNCj4+PiArICAgIGxldCBkZWxheV9ucyA9IGRlbGF5X2Rl
bHRhLmFzX25hbm9zKCk7DQo+Pj4gKw0KPj4+ICsgICAgbG9vcCB7DQo+Pj4gKyAgICAgICAgbGV0
IHZhbCA9IG9wKCk/Ow0KPj4+ICsgICAgICAgIGlmIGNvbmQoJnZhbCkgew0KPj4+ICsgICAgICAg
ICAgICAvLyBVbmxpa2UgdGhlIEMgdmVyc2lvbiwgd2UgaW1tZWRpYXRlbHkgcmV0dXJuLg0KPj4+
ICsgICAgICAgICAgICAvLyBXZSBrbm93IHRoZSBjb25kaXRpb24gaXMgbWV0IHNvIHdlIGRvbid0
IG5lZWQgdG8gY2hlY2sgYWdhaW4uDQo+Pj4gKyAgICAgICAgICAgIHJldHVybiBPayh2YWwpOw0K
Pj4+ICsgICAgICAgIH0NCj4+PiArDQo+Pj4gKyAgICAgICAgaWYgbGVmdF9ucyA8IDAgew0KPj4+
ICsgICAgICAgICAgICAvLyBVbmxpa2UgdGhlIEMgdmVyc2lvbiwgd2UgaW1tZWRpYXRlbHkgcmV0
dXJuLg0KPj4+ICsgICAgICAgICAgICAvLyBXZSBoYXZlIGp1c3QgY2FsbGVkIGBvcCgpYCBzbyB3
ZSBkb24ndCBuZWVkIHRvIGNhbGwgaXQgYWdhaW4uDQo+Pj4gKyAgICAgICAgICAgIHJldHVybiBF
cnIoRVRJTUVET1VUKTsNCj4+PiArICAgICAgICB9DQo+Pj4gKw0KPj4+ICsgICAgICAgIGlmICFk
ZWxheV9kZWx0YS5pc196ZXJvKCkgew0KPj4+ICsgICAgICAgICAgICB1ZGVsYXkoZGVsYXlfZGVs
dGEpOw0KPj4+ICsgICAgICAgICAgICBsZWZ0X25zIC09IGRlbGF5X25zOw0KPj4+ICsgICAgICAg
IH0NCj4+PiArDQo+Pj4gKyAgICAgICAgY3B1X3JlbGF4KCk7DQo+Pj4gKyAgICAgICAgbGVmdF9u
cyAtPSAxOw0KPj4gDQo+PiBBIGNvbW1lbnQgb24gdGhlIGxpbmUgYWJvdmUgd291bGQgYmUgbmlj
ZS4NCj4gDQo+IEFzIEkgd3JvdGUgaW4gYW5vdGhlciBlbWFpbCwgdGhlIEMgdmVyc2lvbiB3YXMg
Y2hhbmdlZCB0byBhdm9pZCB1c2luZw0KPiBrdGltZSwgYW5kIHRoYXSicyB3aGVuIHRoZSBjb2Rl
IGFib3ZlIHdhcyBhZGRlZC4gSSBhc3N1bWUgdGhlIGRlbGF5IGlzDQo+IGNvbnNpZGVyZWQgYXMg
MW5zIGFzIGEgY29tcHJvbWlzZSBiZWNhdXNlIGt0aW1lIGNhbqJ0IGJlIHVzZWQuDQo+IA0KPiBN
YXliZSB0aGlzIGNvbW1lbnQgc2hvdWxkIGJlIGFkZGVkIHRvIHRoZSBDIHZlcnNpb24gaW5zdGVh
ZD8NCg0KSSBtZWFudCB0aGF0IGlmIHdlIGFkZCBhIGNvbW1lbnQgaGVyZSwgbWF5YmUgaXQgc2hv
dWxkIGJlIGFkZGVkIHRvIHRoZQ0KQyB2ZXJzaW9uLg0K

