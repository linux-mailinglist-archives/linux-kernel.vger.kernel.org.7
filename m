Return-Path: <linux-kernel+bounces-866230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47257BFF3DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3223A89EB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63323269D17;
	Thu, 23 Oct 2025 05:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6OtHOUR"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C4242D7C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761196768; cv=none; b=q2AYDzAIk5BvY8EcdgFGDEquCy+KWbbiKJrohn4yoRViXRQtXk1WkDBWg0jPFqV4XgM8zGqZLEfy0Zg3VlCxo/XIoixFuJ+uEmuOjVNzEsu9CoC1SmQphwwJ13Ju5s+cHSYQFjpdHL/4Jt/wQxyTCutZ7QDpB+8cfwIzq8Jttew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761196768; c=relaxed/simple;
	bh=51aXDOGdj/po8jhlXOkKS2wP8VODlnd8UT+bbLyMaxI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N0WVOnz7IY/7BKo/Gm5OstVmM1D5wpMb/Tp4CnF7uU05Ps/vAHHf7/L6C3c9J78By8trPF/NW3evOp+yi8v6MNjacwCU4g3PugaF014tAvlBeXYjE6VsU3F3uP1oLvLg98JmUZbZ/OsWnVSckhmA6qQP4qJOZfl+ElXAsrpVNEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6OtHOUR; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781997d195aso295493b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761196767; x=1761801567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51aXDOGdj/po8jhlXOkKS2wP8VODlnd8UT+bbLyMaxI=;
        b=I6OtHOURNOJC7LHWtRjF6vqF5aH6U/7tLA6LBTdE0KdMQKV3kR/25Rc4zGx7ka9OVv
         irl9jO0SIJf/O0CzqvvuBLrcdWQMo4pYwqZCx0/nrIDKv6ZfkScCEMc736UZSzMESKsL
         R4eMEF0zI6kwLrKMHxlpMU2YHanw6GmVgTzrwR6Kw4lyqDKvFZxV0avXODidOkjfjZfv
         9UcRPxaaQr0nlR5r6zP8cJ9ujSLevp7seYda6kSoOLeYqXLVs9X0EleRnBom0eO/G3Ke
         VRKWSmAvekXaBxxsLF/4kOUJZ4XMA5vMRY9qyJlSr8hI2JahbmS05T145rKnvWzfsDXV
         2uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761196767; x=1761801567;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=51aXDOGdj/po8jhlXOkKS2wP8VODlnd8UT+bbLyMaxI=;
        b=NZLyrSOG72l4WIo5OkSoHs3+44CJNO/uCP8wcqeJ3HVWqMFW2DTgbe7Xpe8K45+fdH
         0/Op8WhJ3pGcukwEFNB0rLcQQDo+yXLzHSf8inIhMcB+heiBpoGjKkk4Blky7S6E72Cq
         4jDbK86izs839DmvJWzh6YVU3HDFiSzg7zR1Sj9NoXr+bZke1uzcxsu8FIZUb2el3bIA
         /E3azmnHSYeulV/iBuf9/obWLkD2PkJnzbg8od0oAbTeBP9fqjpP30EVh6ssGiKwcbb8
         chtAHGt2XC+w5z+5OQGdvqtD/buulDQ2hpfibcLL1FZdd9Av+ECfCjDM3qvG5CMkATkM
         ynAA==
X-Forwarded-Encrypted: i=1; AJvYcCUE4hV0Q/s1hhotzxGvlwknbT3aVyxNSZzgxG6NW5HjaawWqNtAE986YRH4jYyxwOd5kP9aCPv28lN4qzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBbRhxIcXjwdlf4XC1V2lH5TquWoxy23MrtU0259ODoL0R/WF
	ESFXfDnUAQuRBCmVrJXtI8+8j55K0xWSoetzU4CqIhWw9885csFkNgVr
X-Gm-Gg: ASbGncsPHKWiXz6G/2acyRTmMHSqj4HcgM3SOqZSyyGIfXhNV1xtAm+dtV94bK1OyJ5
	88PGwoZFTf2RBy4qxvnrb6tCuvAFCniBAAQNOaqY4he6QH0pqFRwLW/A2aHXBkXR5GAXS65g4S8
	c5D7k9ouaTwLV1bHgdOu5/Wg/SJcySDhwF5Yjqy3tgNoVSHkjW+RvhuxWBEZhaD6r0obf6mmx2k
	IkBi2HIzak6Uu/HcI4//w888dgi0KrmzEmTp23Ci+nGADSA8U8Kbl4tjIDu+p9t4klzEUzrQ2jg
	0q6tbTgCFhZHb7+NkDDrSwE5aw3bIkIxewqItvDvwibKphNcvscjz8nTZAORRV0zI8xL3eOc65w
	2+CJgfndg4rI7WGjLEbibWENNHyOyc+UCosxcsH+RF82iFRLK0vynKQ19JU7c24yohbZwkYDQPk
	Eb/6fiTwv9IIHUIz1hArUXzDATJsXMJL7iiu/jumW04r5VHCdpQ4xXaQ==
X-Google-Smtp-Source: AGHT+IGVsTk3QsyiPJrUe+IqfmTmdgg7c6o5S51y4i/ui4y4RNQVHgrAf90jQBXrDKdEcp6hkc4OOQ==
X-Received: by 2002:a05:6a20:5493:b0:334:99f9:ff45 with SMTP id adf61e73a8af0-334a863c4bemr32416022637.57.1761196766414;
        Wed, 22 Oct 2025 22:19:26 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb8eacsm882436a12.3.2025.10.22.22.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 22:19:25 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:19:09 +0900 (JST)
Message-Id: <20251023.141909.400243634709519102.fujita.tomonori@gmail.com>
To: aliceryhl@google.com, dakr@kernel.org, miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, daniel.almeida@collabora.com,
 a.hindborg@kernel.org, alex.gaynor@gmail.com, ojeda@kernel.org,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 frederic@kernel.org, gary@garyguo.net, jstultz@google.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
 tmgross@umich.edu, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aPjmKSrETqrchW_e@google.com>
References: <DDO3OMBHS8TB.2LDODR1AFRCU3@kernel.org>
	<20251022.193230.585171330619599845.fujita.tomonori@gmail.com>
	<aPjmKSrETqrchW_e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64

T24gV2VkLCAyMiBPY3QgMjAyNSAxNDoxMTo1MyArMDAwMA0KQWxpY2UgUnlobCA8YWxpY2VyeWhs
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IE9uIFdlZCwgT2N0IDIyLCAyMDI1IGF0IDA3OjMyOjMw
UE0gKzA5MDAsIEZVSklUQSBUb21vbm9yaSB3cm90ZToNCj4+IE9uIFR1ZSwgMjEgT2N0IDIwMjUg
MTc6MjA6NDEgKzAyMDANCj4+ICJEYW5pbG8gS3J1bW1yaWNoIiA8ZGFrckBrZXJuZWwub3JnPiB3
cm90ZToNCj4+IA0KPj4gPiBPbiBUdWUgT2N0IDIxLCAyMDI1IGF0IDU6MTMgUE0gQ0VTVCwgTWln
dWVsIE9qZWRhIHdyb3RlOg0KPj4gPj4gaS5lLiBpZiB0aGV5IGFyZW4ndCBzdXJlIHdoYXQgdGhl
IHZhbHVlIGlzLCB0aGVuIEkgd291bGQgcHJlZmVyIHRoZXkNCj4+ID4+IGNsYW1wIGl0IGV4cGxp
Y2l0bHkgb24gdGhlIGNhbGxlZSBzaWRlIChvciB3ZSBwcm92aWRlIGFuIGV4cGxpY2l0bHkNCj4+
ID4+IGNsYW1wZWQgdmVyc2lvbiBpZiBpdCBpcyBhIGNvbW1vbiBjYXNlLCBidXQgaXQgc2VlbXMg
dG8gbWUgcnVudGltZQ0KPj4gPj4gdmFsdWVzIGFyZSBhbHJlYWR5IHRoZSBtaW5vcml0eSkuDQo+
PiA+IA0KPj4gPiBBYnNvbHV0ZWx5ISBFc3BlY2lhbGx5IGdpdmVuIHRoZSBjb250ZXh0IHVkZWxh
eSgpIGlzIGludHJvZHVjZWQNCj4+ID4gKHJlYWRfcG9sbF90aW1lb3V0X2F0b21pYygpKSwgdGhl
IGNvbXBpbGUgdGltZSBjaGVja2VkIHZlcnNpb24gaXMgd2hhdCB3ZSByZWFsbHkNCj4+ID4gd2Fu
dC4NCj4+ID4gDQo+PiA+IE1heWJlIHdlIHNob3VsZCBldmVuIGRlZmVyIGEgcnVudGltZSBjaGVj
a2VkIC8gY2xhbXBlZCB2ZXJzaW9uIHVudGlsIGl0IGlzDQo+PiA+IGFjdHVhbGx5IG5lZWRlZC4N
Cj4+IA0KPj4gVGhlbiBwZXJoYXBzIHNvbWV0aGluZyBsaWtlIHRoaXM/DQo+PiANCj4+ICNbaW5s
aW5lKGFsd2F5cyldDQo+PiBwdWIgZm4gdWRlbGF5KGRlbHRhOiBEZWx0YSkgew0KPj4gICAgIGJ1
aWxkX2Fzc2VydCEoDQo+PiAgICAgICAgIGRlbHRhLmFzX25hbm9zKCkgPj0gMCAmJiBkZWx0YS5h
c19uYW5vcygpIDw9IGk2NDo6ZnJvbShiaW5kaW5nczo6TUFYX1VERUxBWV9NUykgKiAxXzAwMF8w
MDANCj4+ICAgICApOw0KPiANCj4gVGhpcyBpcyBhIGJhZCBpZGVhLiBVc2luZyBidWlsZF9hc3Nl
cnQhIGFzc2VydCBmb3IgcmFuZ2UgY2hlY2tzIHdvcmtzDQo+IHBvb3JseSwgYXMgd2UgZm91bmQg
Zm9yIHJlZ2lzdGVyIGluZGV4IGJvdW5kcyBjaGVja3MuDQoNCk9oLCBJIGRpZG6idCBrbm93IGFi
b3V0IHRoYXQuIERvIHlvdSBoYXZlIGEgcG9pbnRlciBvciBzb21lIGRldGFpbHMgSQ0KY291bGQg
bG9vayBhdD8NCg0KDQo+IElmIHlvdSByZWFsbHkgd2FudCB0byBjaGVjayBpdCBhdCBjb21waWxl
LXRpbWUsIHlvdSdsbCBuZWVkIGEgd3JhcHBlcg0KPiB0eXBlIGFyb3VuZCBEZWx0YSB0aGF0IGNh
biBvbmx5IGJlIGNvbnN0cnVjdGVkIHdpdGggZGVsYXlzIGluIHRoZSByaWdodA0KPiByYW5nZS4N
Cg0KWW91IG1lYW50IHRoYXQgaW50cm9kdWNpbmcgYSBuZXcgdHlwZSBsaWtlIFVkZWxheURlbHRh
LCByaWdodD8NCg0KcmVhZF9wb2xsX3RpbWVvdXQoKSBhbmQgcmVhZF9wb2xsX3RpbWVvdXRfYXRv
bWljKCkgdXNlIGRpZmZlcmVudCBEZWx0YQ0KdHlwZXMuLi4gSSdtIG5vdCBzdXJlIGl0J3MgYSBn
b29kIGlkZWEuDQoNCkRhbmlsbyBhbmQgTWlndWVsLCBhbnkgaWRlYXMgZm9yIG90aGVyIHdheXMg
d2UgY291bGQgZG8gdGhlDQpjb21waWxlLXRpbWUgY2hlY2s/DQoNCg==

