Return-Path: <linux-kernel+bounces-840295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F18BB40AD
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A693B11EB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F7E313280;
	Thu,  2 Oct 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOBaFvcz"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F913128D5
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411838; cv=none; b=UurXgHSxfQFZQx94S7E/IGFrLIS3DbKvkGDo6qCBQ8Wd4/nZVLULbqFSb5sGvy3DGmJluUK8Sw5HgLyuAMuEAxcYALlfrYdV1BysLbuH0Y6Qy1wkZZ/ku3Xb0VAQ8W4UnjgyxLXQVMUS4pAvlg8p0uHlmbvU0zdGoIj19ho5Lio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411838; c=relaxed/simple;
	bh=OylijEb90SOQ6UrbwkSQ7aXtXmPX3tnvxpOk6Uy1ypE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jw7gtj3sCPWBspMtcmhuuzv8tku57WblQmjj54tpvOUkJ+oraTuxooUMYS1ar4Qk7CSAc7ikQ3FmqL+ghWmmpCrKUjC6F4FmZdgP/6jZzlRAe+VPt/82onJ5mstSx8eSNgYvWTxu0ANMIvGY/qMbGyykuNyWM+YnLrh93Mg7/nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOBaFvcz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b457d93c155so196630366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 06:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759411834; x=1760016634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OylijEb90SOQ6UrbwkSQ7aXtXmPX3tnvxpOk6Uy1ypE=;
        b=TOBaFvcztECaowMTyYQcE+8R3Wgf88HY8/7q1eyV4EGNSHGomhBJx1rY4bloDl/8Oz
         GdBjzTjnidv+cp4DwZ5VuPos9rlZUnAwF9zaoaRWnA7P0NwD0ZGPD22U3M+qKS0l8h6p
         N10QpTcSFGKTPtFyRfPQyHqM70AmISk71BLGK+NLCHmr17TKWq1fdORD9M0AodwMcFKQ
         1nh5QqmrzrTl6Tyl1vdkvopBOBeWqvsI+8c8b1zbu3tjtvszkw1E1tqdkdbonVaqpHuN
         TZt8tc3YuzgiQrpQwpPZ1AeYYTgFiXi5WannffwsEYXVS/7J86CT3+eHR/n/+yhFRUAi
         z/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759411834; x=1760016634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OylijEb90SOQ6UrbwkSQ7aXtXmPX3tnvxpOk6Uy1ypE=;
        b=wlia9kJJd8aHbY8PT9nrPmIFk0Uq9ZbfFoFBQtjzJDUIHwioR/uXZDbJ/IZSUDMHYo
         FXm1HnPPNuy8zv4s2gGE1SkQp1VTWoIzoeVuLeO4mHGIAOUOui7SnQjQ+KwK65qRHskL
         GuNRTZ+PKYui/anh9yzrk3k96jK395tBNPibcLJj/8oKLgjPekJNuhIEqs7AtQX2DTDI
         Px0iKT+AL+MXYqt6vUec+Cbiv2QHWdlTWhTMNegz0ZIwlkcsZEmDDCIkl1kBS9ZhcrXl
         H9yyxfxKIFBQKLb3TeqTzwXy4cOyehRnSfat0C9FjfkQ1js0Fqs3kgwpUSPsbjvnmOyu
         1R4A==
X-Forwarded-Encrypted: i=1; AJvYcCXeacZ07hvQTa5PfOPd7DjSlxdPwth8/i5xIoD+P8Aq93NPasbcGzlc6C0zrWPk8VNp4Qnw6WG4lnKiqSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywos9Ej0JNtmxNN0Tg9nfK72sqgAacmmerlp6x7qcK06w5H8QPn
	GB1+/5r4vRHjYYlgjCN/LLc1fPwVmFebpC62mzV+LSeDfwAorLnM7EYVttDK5QN4bwsu6n6YI+j
	SzoASM4UKy1FwXyTDhj32NzV4Xl7HO04=
X-Gm-Gg: ASbGncusg5NA38hf1BMC2A+06Y2YuDedVuP751Kna4eKDgSCgEbganqVF+DEaXHOQWF
	R/tJavvmyxzWKRSGdEwQnxZEa4+bUDLc80wCOoKEe8ueNAcTIByU3nPGSdzU2fOz5mldcQHVfJq
	v7THWVGFyJDKUk0+V7u6BSRCxNLUoWnNW5S4GuDsdOwoxHEeez02/zeaY2e5t/Er68wNOZrtE6d
	xETFxyaFONl+5TwW+cX8V8VisAEkvE=
X-Google-Smtp-Source: AGHT+IFgJFQIf8LemrW92kXP651kHHmCUgfOqMCjSP+iK1iAH8rm+dPRjQvoRpFjxzju8IDVoxl1tPPM/cd+9tbuDko=
X-Received: by 2002:a17:907:7e88:b0:b2d:830a:8c01 with SMTP id
 a640c23a62f3a-b46e7db5121mr812057566b.61.1759411834160; Thu, 02 Oct 2025
 06:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924235114.209967-1-benx.guo@gmail.com> <82c7e76c-326f-45c9-bff7-1f27bf0c689c@linux.dev>
In-Reply-To: <82c7e76c-326f-45c9-bff7-1f27bf0c689c@linux.dev>
From: Alex Shi <seakeel@gmail.com>
Date: Thu, 2 Oct 2025 21:29:57 +0800
X-Gm-Features: AS18NWDnm0zMPaqPWOaHAI27cFxCOfRCMG7AYaFK8tTwOMCuQUgCDwpX7O0f2rM
Message-ID: <CAJy-Am=eGRK4-az_L32jFt1K+zRcJSvX5-qG1brG3wQ5dRPXpA@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Update Rust index translation and add
 reference label
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Ben Guo <benx.guo@gmail.com>, alexs@kernel.org, dzm91@hust.edu.cn, corbet@lwn.net, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, hust-os-kernel-patches@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

QXBwaWxlZCBUaGFua3MNCg0KWWFudGVuZyBTaSA8c2kueWFudGVuZ0BsaW51eC5kZXY+IOS6jjIw
MjXlubQ55pyIMjXml6Xlkajlm5sgMDk6NTHlhpnpgZPvvJoNCj4NCj4NCj4g5ZyoIDkvMjUvMjUg
Nzo1MSBBTSwgQmVuIEd1byDlhpnpgZM6DQo+ID4gVXBkYXRlIHRoZSB0cmFuc2xhdGVkIHJ1c3Qv
aW5kZXgucnN0IHdpdGggbmV3IGNvbnRlbnRzLA0KPiA+IGFuZCBhZGQgYSByZWZlcmVuY2UgbGFi
ZWwgaW4gcnVzdC9nZW5lcmFsLWluZm9ybWF0aW9uLnJzdCBzbw0KPiA+IHRoYXQgaW5kZXgucnN0
IGNhbiBsaW5rIHRvIGl0IHByb3Blcmx5Lg0KPiA+DQo+ID4gRml4ZXMgaW4gcnVzdC9pbmRleC5y
c3Q6DQo+ID4gLSBGaXhlZCBicm9rZW4gcXVpY2stc3RhcnQucnN0IGNyb3NzLXJlZmVyZW5jZQ0K
PiA+DQo+ID4gVXBkYXRlIHRoZSB0cmFuc2xhdGlvbiB0aHJvdWdoIGNvbW1pdCBkMGIzNDM2MDVm
MWINCj4gPiAoImtlcm5lbC1kb2NzOiBBZGQgbmV3IHNlY3Rpb24gZm9yIFJ1c3QgbGVhcm5pbmcg
bWF0ZXJpYWxzIikNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJlbiBHdW8gPGJlbnguZ3VvQGdt
YWlsLmNvbT4NCj4NCj4gUmV2aWV3ZWQtYnk6IFlhbnRlbmcgU2kgPHNpLnlhbnRlbmdAbGludXgu
ZGV2Pg0KPg0KPg0KPiBUaGFua3MsDQo+DQo+IFlhbnRlbmcNCj4NCj4gPiAtLS0NCj4gPiAgIC4u
Li96aF9DTi9ydXN0L2dlbmVyYWwtaW5mb3JtYXRpb24ucnN0ICAgICAgICB8ICAxICsNCj4gPiAg
IC4uLi90cmFuc2xhdGlvbnMvemhfQ04vcnVzdC9pbmRleC5yc3QgICAgICAgICB8IDMyICsrKysr
KysrKysrKysrKysrKy0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNs
YXRpb25zL3poX0NOL3J1c3QvZ2VuZXJhbC1pbmZvcm1hdGlvbi5yc3QgYi9Eb2N1bWVudGF0aW9u
L3RyYW5zbGF0aW9ucy96aF9DTi9ydXN0L2dlbmVyYWwtaW5mb3JtYXRpb24ucnN0DQo+ID4gaW5k
ZXggMjUxZjZlZTJiYjQ0Li45YjVlMzdlMTNmMzggMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRh
dGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcnVzdC9nZW5lcmFsLWluZm9ybWF0aW9uLnJzdA0KPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3J1c3QvZ2VuZXJhbC1pbmZv
cm1hdGlvbi5yc3QNCj4gPiBAQCAtMTMsNiArMTMsNyBAQA0KPiA+DQo+ID4gICDmnKzmlofmoaPl
jIXlkKvkuoblnKjlhoXmoLjkuK3kvb/nlKhSdXN05pSv5oyB5pe26ZyA6KaB5LqG6Kej55qE5pyJ
55So5L+h5oGv44CCDQo+ID4NCj4gPiArLi4gX3J1c3RfY29kZV9kb2N1bWVudGF0aW9uX3poX2Nu
Og0KPiA+DQo+ID4gICDku6PnoIHmlofmoaMNCj4gPiAgIC0tLS0tLS0tDQo+ID4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3J1c3QvaW5kZXgucnN0IGIvRG9j
dW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcnVzdC9pbmRleC5yc3QNCj4gPiBpbmRleCBi
MDFmODg3ZTcxNjcuLjEwNDEzYjBjMTdjMCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L3RyYW5zbGF0aW9ucy96aF9DTi9ydXN0L2luZGV4LnJzdA0KPiA+ICsrKyBiL0RvY3VtZW50YXRp
b24vdHJhbnNsYXRpb25zL3poX0NOL3J1c3QvaW5kZXgucnN0DQo+ID4gQEAgLTEwLDcgKzEwLDM1
IEBADQo+ID4gICBSdXN0DQo+ID4gICA9PT09DQo+ID4NCj4gPiAt5LiO5YaF5qC45Lit55qEUnVz
dOacieWFs+eahOaWh+aho+OAguiLpeimgeW8gOWni+WcqOWGheaguOS4reS9v+eUqFJ1c3TvvIzo
r7fpmIXor7txdWljay1zdGFydC5yc3TmjIfljZfjgIINCj4gPiAr5LiO5YaF5qC45Lit55qEUnVz
dOacieWFs+eahOaWh+aho+OAguiLpeimgeW8gOWni+WcqOWGheaguOS4reS9v+eUqFJ1c3TvvIzo
r7fpmIXor7sgcXVpY2stc3RhcnQucnN0IOaMh+WNl+OAgg0KPiA+ICsNCj4gPiArUnVzdCDlrp7p
qowNCj4gPiArLS0tLS0tLS0tDQo+ID4gK1J1c3Qg5pSv5oyB5ZyoIHY2LjEg54mI5pys5Lit5ZCI
5bm25Yiw5Li757q/77yM5Lul5biu5Yqp56Gu5a6aIFJ1c3Qg5L2c5Li65LiA56eN6K+t6KiA5piv
5ZCm6YCC5ZCI5YaF5qC477yMDQo+ID4gK+WNs+aYr+WQpuWAvOW+l+i/m+ihjOadg+ihoeOAgg0K
PiA+ICsNCj4gPiAr55uu5YmN77yMUnVzdCDmlK/mjIHkuLvopoHpnaLlkJHlr7kgUnVzdCDmlK/m
jIHmhJ/lhbTotqPnmoTlhoXmoLjlvIDlj5HkurrlkZjlkoznu7TmiqTogIXvvIwNCj4gPiAr5Lul
5L6/5LuW5Lus5Y+v5Lul5byA5aeL5aSE55CG5oq96LGh5ZKM6amx5Yqo56iL5bqP77yM5bm25biu
5Yqp5byA5Y+R5Z+656GA6K6+5pa95ZKM5bel5YW344CCDQo+ID4gKw0KPiA+ICvlpoLmnpzmgqjm
mK/nu4jnq6/nlKjmiLfvvIzor7fms6jmhI/vvIznm67liY3msqHmnInpgILlkIjmiJbml6jlnKjn
lJ/kuqfkvb/nlKjnmoTlhoXnva7pqbHliqjnqIvluo/miJbmqKHlnZfvvIwNCj4gPiAr5bm25LiU
IFJ1c3Qg5pSv5oyB5LuN5aSE5LqO5byA5Y+RL+WunumqjOmYtuaute+8jOWwpOWFtuaYr+WvueS6
jueJueWumuWGheaguOmFjee9ruOAgg0KPiA+ICsNCj4gPiAr5Luj56CB5paH5qGjDQo+ID4gKy0t
LS0tLS0tDQo+ID4gKw0KPiA+ICvnu5nlrprkuIDkuKrlhoXmoLjphY3nva7vvIzlhoXmoLjlj6/o
g73kvJrnlJ/miJAgUnVzdCDku6PnoIHmlofmoaPvvIzljbPnlLEgYGBydXN0ZG9jYGAg5bel5YW3
5ZGI546w55qEIEhUTUzjgIINCj4gPiArDQo+ID4gKy4uIG9ubHk6OiBydXN0ZG9jIGFuZCBodG1s
DQo+ID4gKw0KPiA+ICsgICDor6XlhoXmoLjmlofmoaPkvb/nlKggYFJ1c3Qg5Luj56CB5paH5qGj
IDxydXN0ZG9jL2tlcm5lbC9pbmRleC5odG1sPmBfIOaehOW7uuOAgg0KPiA+ICsNCj4gPiArLi4g
b25seTo6IG5vdCBydXN0ZG9jIGFuZCBodG1sDQo+ID4gKw0KPiA+ICsgICDor6XlhoXmoLjmlofm
oaPkuI3kvb/nlKggUnVzdCDku6PnoIHmlofmoaPmnoTlu7rjgIINCj4gPiArDQo+ID4gK+mihOeU
n+aIkOeJiOacrOaPkOS+m+WcqO+8mmh0dHBzOi8vcnVzdC5kb2NzLmtlcm5lbC5vcmfjgIINCj4g
PiArDQo+ID4gK+ivt+WPgumYhSA6cmVmOmDku6PnoIHmlofmoaMgPHJ1c3RfY29kZV9kb2N1bWVu
dGF0aW9uX3poX2NuPmAg6YOo5YiG5Lul6I635Y+W5pu05aSa6K+m57uG5L+h5oGv44CCDQo+ID4N
Cj4gPiAgIC4uIHRvY3RyZWU6Og0KPiA+ICAgICAgIDptYXhkZXB0aDogMQ0KPiA+IEBAIC0yMCw2
ICs0OCw4IEBAIFJ1c3QNCj4gPiAgICAgICBjb2RpbmctZ3VpZGVsaW5lcw0KPiA+ICAgICAgIGFy
Y2gtc3VwcG9ydA0KPiA+DQo+ID4gK+S9oOi/mOWPr+S7peWcqCA6ZG9jOmAuLi8uLi8uLi9wcm9j
ZXNzL2tlcm5lbC1kb2NzYCDkuK3mib7liLAgUnVzdCDnmoTlrabkuaDmnZDmlpnjgIINCj4gPiAr
DQo+ID4gICAuLiBvbmx5OjogIHN1YnByb2plY3QgYW5kIGh0bWwNCj4gPg0KPiA+ICAgICAgSW5k
aWNlcw0K

