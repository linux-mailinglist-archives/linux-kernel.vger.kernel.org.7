Return-Path: <linux-kernel+bounces-786585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA99B35E9D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662623B069F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3291930146D;
	Tue, 26 Aug 2025 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/0uT9Ps"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316411B6CE9;
	Tue, 26 Aug 2025 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209600; cv=none; b=maNcM9yVFY+pUwiV4ZBvaCqRh2dEFBDKDHoUx74L5OwYYVFTI6pzO7WwKhp16MkYXUr/kUCPp3MmqRBxL76PjqMv7Mx6IdVef1y7As2whnmhF2kNcbHeXJtopnSorDuIwaA/8nqlUfddP7RRxvzB+2/gM+ycSwdrRg9UjQU31hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209600; c=relaxed/simple;
	bh=19LSBPHUQsnPLxLO0uJ1B004qvDgLhT0SmAmTMNJxos=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hCNha3+62SNPbLIuonM4Ez+GO46xv4haTr0/G4csbRMvuZkl8VoYUzdmY6Gb7dmzMAcQJI2PAXur5LDPArxu04mLYzetd17ClLGOftmMIKin1Fm71RACRo5XnofZEFDeu4TfEKDAwjyQl/jxpZWMHSi+qtr8ubnJ0D/TKj2P6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/0uT9Ps; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4c1ed55930so1923800a12.1;
        Tue, 26 Aug 2025 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756209597; x=1756814397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19LSBPHUQsnPLxLO0uJ1B004qvDgLhT0SmAmTMNJxos=;
        b=N/0uT9PsEaUZ5HD2PHTiHHVfj9y76RPnuTfCsvDNXUq2bUavQ6ofdL5HDSPtUQXfaC
         X43Wc0gu1W1f7ahsHpsichYu+hpjaIpdiOpnG1zclGFIdUFvefgRXtfNwSc0w8j1KvpK
         YXOkFVposARwvBMQmpyB5myf6/umRKc/t53Je9aSlf1EVN7V0dl3AZSanJrnoSgp9XPT
         QF7vRK3tzgAhCgjntQGKr7OExylLaWNZFoKZTIfZz3c71EQFXkteNYt2fAgiHeFq0v8s
         ywK8Ha3yOpNXjsJhEqgfpQc3TzcECCIuogT/g4sjUzlV43gIYJFaDxJcUe/mj5y5ZROg
         mZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756209597; x=1756814397;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=19LSBPHUQsnPLxLO0uJ1B004qvDgLhT0SmAmTMNJxos=;
        b=c9Z9BeNmbW+8J5keE/aVb7V5O36VIHSC/geT79y1c5CA9sx5aeV0Vri2RDe+1fTIsV
         jCP88/8d8BG3QRoHj8o+/hdt68QiY4sE7GiG4KkAVJo5Wr0Nx7jMp2nmF8W2Oz6fjHBI
         C3UhbnwmfR0fuQe8fJaUnRqMaovIj6QiJGB+Ys+qAgCh6Ca4KSG1XHASlEXu5TEFC/pK
         uwa3yJyJM1Fv1gCQ356f+aTxM5pr6EyY55iow3GeWHCo6Wm/YCmjpWp+i32LI91DEIr9
         Jnkbg2NVOjiJ46/czbeRIQdLgVqFqJXSczdmtZYJu24IAD5ci/VFv1RIQ0vAd83xeI/1
         z7JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFElNOLb8ko1Xhw7gde647xZ1ZAx3UhA23lctPmZuYnQgSfUrrtDjC7hK/CkiaGYRfCyQ2ThMaMKA2ixCLf6I=@vger.kernel.org, AJvYcCX4sqH+YyGA0Wty3SjD7OvzfzXE4hnEoCdc5aomctvZJ/lG5Q6W2EYxScabHvOg+hJxQ7/4YQDtxXLHMuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykBmIaRlDaQcOR8K6HOQGsVEt+bNJh7TphgEhyrCBOGZvYN+Zg
	R6RD+kdhm4m0NKoCea+DZIPwbzjkldhwf9OTj6hPPNauAS43/nYoiuYd
X-Gm-Gg: ASbGnctbWMqVGqvvd5SG1bTgVuP2gbsvbMw3LiqNiixuXUT3eKqnwh/Vidp8YaldMnn
	RfXIMQcWgy/J7hj8ZP9OZZgo21me04gTGYSRprb8F7rx5c/fUgqD2tLuVHAN7YZYlW/HWoi/fvt
	3neDfVbeU1qMBNVnRbWdf8E6i401jHFzYsuUu4LkF9iNpthrY5ALNtiqYYsdiUW58nozwLx+OaA
	kegDKAxskxaLJqxq5n1D3Lvq8Px+YAoJBkDDDYCebiY1wzjzb3s6NfNSe4fiUx0x0DH4S6TQdcm
	DkSX+LZB8K3vh0TQFH6EXoFGpZILTJZUSe1EuAkzeZSti2RsFUCg67M4GwrsGjN/AGCyDxPTTu5
	UOZPbf5SmvBdGTxvvfofefgHnz/wNv7aRhKMv/+d0M0JwnW2pwVNQLXPXwMUOtfqT3PWx8fXDO7
	Aw
X-Google-Smtp-Source: AGHT+IGw9o/NEVIe3ivChryZIGHUTUQAQ5+1L3wB6SWowOPDKHyu4TGa+ygIiQqXBHD5Dkix86KddQ==
X-Received: by 2002:a17:903:19cc:b0:246:4077:454b with SMTP id d9443c01a7336-24640774da7mr167013635ad.33.1756209597253;
        Tue, 26 Aug 2025 04:59:57 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668779ffcsm94180485ad.18.2025.08.26.04.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:59:56 -0700 (PDT)
Date: Tue, 26 Aug 2025 20:59:41 +0900 (JST)
Message-Id: <20250826.205941.963904478024459782.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: fujita.tomonori@gmail.com, alex.gaynor@gmail.com, ojeda@kernel.org,
 aliceryhl@google.com, anna-maria@linutronix.de, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, dakr@kernel.org, frederic@kernel.org,
 gary@garyguo.net, jstultz@google.com, linux-kernel@vger.kernel.org,
 lossin@kernel.org, lyude@redhat.com, rust-for-linux@vger.kernel.org,
 sboyd@kernel.org, tglx@linutronix.de, tmgross@umich.edu,
 acourbot@nvidia.com, daniel.almeida@collabora.com
Subject: Re: [PATCH v1 1/2] rust: add udelay() function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <87bjo2witj.fsf@t14s.mail-host-address-is-not-set>
References: <ub8ohgErgUJB1KWyrSWn18gSQiyiIJ4Py133yi5fMR68ZG2zeWokoP7kULU7voBjry46A7GZUSrHuCQn0C_DZg==@protonmail.internalid>
	<20250821035710.3692455-2-fujita.tomonori@gmail.com>
	<87bjo2witj.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64

T24gVHVlLCAyNiBBdWcgMjAyNSAxMTowOToxMiArMDIwMA0KQW5kcmVhcyBIaW5kYm9yZyA8YS5o
aW5kYm9yZ0BrZXJuZWwub3JnPiB3cm90ZToNCg0KPj4gKy8vLyBJbnNlcnRzIGEgZGVsYXkgYmFz
ZWQgb24gbWljcm9zZWNvbmRzIHdpdGggYnVzeSB3YWl0aW5nLg0KPj4gKy8vLw0KPj4gKy8vLyBF
cXVpdmFsZW50IHRvIHRoZSBDIHNpZGUgW2B1ZGVsYXkoKWBdLCB3aGljaCBkZWxheXMgaW4gbWlj
cm9zZWNvbmRzLg0KPj4gKy8vLw0KPj4gKy8vLyBgZGVsdGFgIG11c3QgYmUgd2l0aGluIGBbMCwg
YE1BWF9VREVMQVlfTVNgXWAgaW4gbWlsbGlzZWNvbmRzOw0KPj4gKy8vLyBvdGhlcndpc2UsIGl0
IGlzIGVycm9uZW91cyBiZWhhdmlvci4gVGhhdCBpcywgaXQgaXMgY29uc2lkZXJlZCBhIGJ1ZyB0
bw0KPj4gKy8vLyBjYWxsIHRoaXMgZnVuY3Rpb24gd2l0aCBhbiBvdXQtb2YtcmFuZ2UgdmFsdWUs
IGluIHdoaWNoIGNhc2UgdGhlIGZ1bmN0aW9uDQo+PiArLy8vIHdpbGwgaW5zZXJ0IGEgZGVsYXkg
Zm9yIGF0IGxlYXN0IHRoZSBtYXhpbXVtIHZhbHVlIGluIHRoZSByYW5nZSBhbmQNCj4+ICsvLy8g
bWF5IHdhcm4gaW4gdGhlIGZ1dHVyZS4NCj4+ICsvLy8NCj4+ICsvLy8gVGhlIGJlaGF2aW9yIGFi
b3ZlIGRpZmZlcnMgZnJvbSB0aGUgQyBzaWRlIFtgdWRlbGF5KClgXSBmb3Igd2hpY2ggb3V0LW9m
LXJhbmdlDQo+PiArLy8vIHZhbHVlcyBjb3VsZCBsZWFkIHRvIGFuIG92ZXJmbG93IGFuZCB1bmV4
cGVjdGVkIGJlaGF2aW9yLg0KPj4gKy8vLw0KPj4gKy8vLyBbYHVkZWxheSgpYF06IGh0dHBzOi8v
ZG9jcy5rZXJuZWwub3JnL3RpbWVycy9kZWxheV9zbGVlcF9mdW5jdGlvbnMuaHRtbCNjLnVkZWxh
eQ0KPj4gK3B1YiBmbiB1ZGVsYXkoZGVsdGE6IERlbHRhKSB7DQo+PiArICAgIGNvbnN0IE1BWF9V
REVMQVlfREVMVEE6IERlbHRhID0gRGVsdGE6OmZyb21fbWlsbGlzKGJpbmRpbmdzOjpNQVhfVURF
TEFZX01TIGFzIGk2NCk7DQo+PiArDQo+PiArICAgIGxldCBkZWx0YSA9IGlmIChEZWx0YTo6WkVS
Ty4uPU1BWF9VREVMQVlfREVMVEEpLmNvbnRhaW5zKCZkZWx0YSkgew0KPj4gKyAgICAgICAgZGVs
dGENCj4+ICsgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgIC8vIFRPRE86IEFkZCBXQVJOX09OQ0Uo
KSB3aGVuIGl0J3Mgc3VwcG9ydGVkLg0KPj4gKyAgICAgICAgTUFYX1VERUxBWV9ERUxUQQ0KPj4g
KyAgICB9Ow0KPj4gKw0KPj4gKyAgICAvLyBTQUZFVFk6IEl0IGlzIGFsd2F5cyBzYWZlIHRvIGNh
bGwgYHVkZWxheSgpYCB3aXRoIGFueSBkdXJhdGlvbi4NCj4gDQo+IEZ1bmN0aW9uIGRvY3VtZW50
YXRpb24gc2F5cyBpdCBpcyBvdmVyZmxvdyBhbmQgdW5leHBlY3RlZCBiZWhhdmlvciB0bw0KPiBj
YWxsIGB1ZGVsYXlgIHdpdGggb3V0IG9mIHJhbmdlIHZhbHVlLCBidXQgYWJvdmUgY29tbWVudCBz
YXlzIGFueQ0KPiBkdXJhdGlvbiBpcyBzYWZlLiBXaGljaCBpcyBpdD8NCg0KVGhpcyBjYW4gbGVh
ZCB0byBhbiB1bmV4cGVjdGVkIGRlbGF5IGR1cmF0aW9uLCBidXQgaXQncyBzYWZlIGluIFJ1c3Si
cw0Kc2Vuc2Ugb2Ygc2FmZXR5Pw0KDQpJZiBub3QsIGhvdyBhYm91dCB0aGUgZm9sbG93aW5ncz8N
Cg0KLy8gU0FGRVRZOiBgZGVsdGFgIGlzIGNsYW1wZWQgdG8gdGhlIHJhbmdlIFswLCBNQVhfVURF
TEFZX0RFTFRBXSwNCi8vIHNvIGNhbGxpbmcgYHVkZWxheSgpYCB3aXRoIGl0IGlzIGFsd2F5cyBz
YWZlLg0K

