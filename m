Return-Path: <linux-kernel+bounces-859086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5BFBECC05
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 000FA4E4F0E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D912EB87A;
	Sat, 18 Oct 2025 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWD7mN6g"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E9519F121
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760777926; cv=none; b=BiMOknHJ2MKKQjoXnrQ2uwjtTOyFkgza3tpXi4Ckwwemm1LAam07nn1hU0mUdOK2RHA2s/iAEp2xoYBZAWsBlKAQAqOIoTpWapjgRIkvfZbU8awOsCCzynlWcjT64MaJnzuDnFA9RFELj0zlBtMsv+afTK84BD3pHoFlChkc+iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760777926; c=relaxed/simple;
	bh=BuFqsr7FhCdWHatTTI/P+F9i1jjzz7jypMZESfp9TL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EToGV4CSTfwypHiZjl18C37BcjaPg0HL2DWYI9YTeSiCQOLZ7PImzsiYHSGg0BwhzM08oSuz2bUrKbGcKwPO06Oy4OLjBz4M7q6xop3Ilz0eC+VdXxBPj5ZXHqSV4XgeFIlsHyqZ9e8KFIojY3YjSRYFoodG6kS3tAWWaKvt/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWD7mN6g; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3ee18913c0so488018366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760777923; x=1761382723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuFqsr7FhCdWHatTTI/P+F9i1jjzz7jypMZESfp9TL8=;
        b=gWD7mN6g9QQvOzVekaIKycP+7lpAbwkXffVKVon+HVIDcswFcYp48P+7au5WtZsh0p
         vnnIpo+KVaExx3atWBmEMDFeBzE2hoMpnigA/q40a9hZlfrpfeoNZ1Gvxghh4wmKLfn5
         rrj/CCg2RQKHwqzrsqIuBM/1S5BsFwnZzISXevBRLKugCHZ+gVcsG+ITC1a+9qUIJrzq
         DL0/aWVpNahVc3El9O+JDYXV0CyCHm+vodxZtTey5NCj2Mhni4nKWawScFauKioX9eUM
         yEY6Hq6VrFEIpIzi/rtd75QC6BfvIUO9GHqXGt60tMtnwu/cObANtkRA/t9vJTnLMVIr
         ZpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760777923; x=1761382723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuFqsr7FhCdWHatTTI/P+F9i1jjzz7jypMZESfp9TL8=;
        b=M02qT8W58vyZBWizCkUaLBRbyZM9e0htrdkKgWpM3J0CJbzj6Vy/mgQKa9iNt71P2U
         djg754HzliwKH4LXk5l39fNcONgKP08ICs4t5lynFCj5v0WTQWXlPT6+BcLjLbox6gzA
         qxo+eMtTeckfGM54QsoR3xHblxU0OlJt+KFfN8ovlY0DI9y3N7Z2wUo8f7eKRLAGv7jl
         pHPNIreXOpx50ZSnj88VY6IGEtS1NcjK5I5mTIQ1TZy/+bf5iUwc4ibTYRGXofDastLL
         8t565xSapxgE1s+xv/zCH4IsH5SgB/8I5ePn0eFKl/H4XHGePlpHL0zjaKbJcLWXm1iq
         G5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU1kUqf3LvjnbeM5UsEOVoHsKpauYzrRcV5JtX8Uap2IHd0xZIziUv6kRkXDKzP/AAH1JMy+MzH3iiKnUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgDXRIp5ebK5a2P0oyOUdOZfQeNr/qXb1/XBHDMLlni/uiY6R
	7U1lRcfr6IAsbx8ezbqqigW7LWPTfIMx5hbU4x2+LcGTrNULNzX0u64I6Nxul7qo+oXj0R7JsfZ
	ys9/QGd5xVDtO8Nswydn+VLMyRyfexzL0doc+yFuKiA==
X-Gm-Gg: ASbGncuAtOojl8eL/AlKCGqXA4L7ZQ7BOwUwgDwwz+1VcQs+emNFNFoeP+LwEDV//7s
	3bpUm3yb7K2kCYJDTg4kydl5K7mDGLYAdQqVSkV+VVM2da8miSZqOZsm3ejtcurRK/N6518CRQu
	lgUe+yWkjgvypnA3UQBGxkjVccbqfn8W0T4Y2doJxcIjTpaC5IKCGWER7V3Q1qCSy4sjMqMwVKJ
	tA/gfLGG6JRbuq4JLW+NduFEUsz6CfMznMcdy3QwCJXBZCffnH0xqTU7IwCLqcrqiyr/KDygKpX
	eBBa+Q==
X-Google-Smtp-Source: AGHT+IHvORysSvv56rnlgB1wBg5HQ8zoKX1jUqqghgl/CTdO/qYMKac7Cf2ZfH6eGyrlSjwlABHRELMaGg+lKNSv7+Q=
X-Received: by 2002:a17:907:ea5:b0:b3f:5049:9e81 with SMTP id
 a640c23a62f3a-b6474940fccmr664378666b.47.1760777922976; Sat, 18 Oct 2025
 01:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013031928.36643-1-zhaoshuo@cqsoftware.com.cn>
In-Reply-To: <20251013031928.36643-1-zhaoshuo@cqsoftware.com.cn>
From: Alex Shi <seakeel@gmail.com>
Date: Sat, 18 Oct 2025 16:58:06 +0800
X-Gm-Features: AS18NWD5AmS0NICobKxn_92sP6aMVvE1d-Zs5hIv1ty3hzAIi3JsguQppguV2ss
Message-ID: <CAJy-Amk4O3o28ZXkwUxm3nW6A5r4o6-yRDZ-D+Gxv1u3aRTr_w@mail.gmail.com>
Subject: Re: [PATCH v2] docs/zh_CN: Add secrets coco Chinese translation
To: Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
Cc: alexs@kernel.org, si.yanteng@linux.dev, corbet@lwn.net, dzm91@hust.edu.cn, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

QXBwbGllZCwgVGhhbmtzDQoNClNodW8gWmhhbyA8emhhb3NodW9AY3Fzb2Z0d2FyZS5jb20uY24+
IOS6jjIwMjXlubQxMOaciDEz5pel5ZGo5LiAIDExOjE55YaZ6YGT77yaDQo+DQo+IFRyYW5zbGF0
ZSAuLi4vc2VjdXJpdHkvc2VjcmV0cy9jb2NvLnJzdCBpbnRvIENoaW5lc2UuDQo+DQo+IFVwZGF0
ZSB0aGUgdHJhbnNsYXRpb24gdGhyb3VnaCBjb21taXQgZDU2YjY5OWQ3NmQxDQo+ICgiRG9jdW1l
bnRhdGlvbjogRml4IHR5cG9zIikuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFNodW8gWmhhbyA8emhh
b3NodW9AY3Fzb2Z0d2FyZS5jb20uY24+DQo+IC0tLQ0KPg0KPiB2MjoNCj4NCj4gUmV2aXNlIHRo
ZSByZWZlcmVuY2VzLg0KPg0KPiAgLi4uL3poX0NOL3NlY3VyaXR5L3NlY3JldHMvY29jby5yc3Qg
ICAgICAgICAgIHwgOTYgKysrKysrKysrKysrKysrKysrKw0KPiAgLi4uL3poX0NOL3NlY3VyaXR5
L3NlY3JldHMvaW5kZXgucnN0ICAgICAgICAgIHwgIDkgKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwg
OTkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9zZWN1cml0eS9zZWNyZXRzL2NvY28ucnN0
DQo+DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9zZWN1
cml0eS9zZWNyZXRzL2NvY28ucnN0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04v
c2VjdXJpdHkvc2VjcmV0cy9jb2NvLnJzdA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRl
eCAwMDAwMDAwMDAwMDAuLmEyN2JjMWFjZGI3Yw0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3NlY3VyaXR5L3NlY3JldHMvY29jby5yc3QN
Cj4gQEAgLTAsMCArMSw5NiBAQA0KPiArLi4gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjANCj4gKy4uIGluY2x1ZGU6OiAuLi8uLi9kaXNjbGFpbWVyLXpoX0NOLnJzdA0KPiArDQo+ICs6
T3JpZ2luYWw6IERvY3VtZW50YXRpb24vc2VjdXJpdHkvc2VjcmV0cy9jb2NvLnJzdA0KPiArDQo+
ICs657+76K+ROg0KPiArDQo+ICsg6LW156GVIFNodW8gWmhhbyA8emhhb3NodW9AY3Fzb2Z0d2Fy
ZS5jb20uY24+DQo+ICsNCj4gKz09PT09PT09PT09PQ0KPiAr5py65a+G6K6h566X5a+G6ZKlDQo+
ICs9PT09PT09PT09PT0NCj4gKw0KPiAr5pys5paH5qGj5LuL57uN5LqG5ZyoRUZJ6amx5Yqo56iL
5bqP5ZKMZWZpX3NlY3JldOWGheaguOaooeWdl+S4re+8jOacuuWvhuiuoeeul+WvhumSpeS7juWb
uuS7tg0KPiAr5Yiw5pON5L2c57O757uf55qE5rOo5YWl5aSE55CG5rWB56iL44CCDQo+ICsNCj4g
K+eugOS7iw0KPiArPT09PQ0KPiArDQo+ICvmnLrlr4borqHnrpfnoazku7bvvIjlpoJBTUQgU0VW
77yMU2VjdXJlIEVuY3J5cHRlZCBWaXJ0dWFsaXphdGlvbu+8ieWFgeiuuOiZmuaLn+acug0KPiAr
5omA5pyJ6ICF5bCG5a+G6ZKl5rOo5YWl6Jma5ouf5py677yIVk3vvInlhoXlrZjvvIzkuJTkuLvm
nLov6Jma5ouf5py655uR5o6n56iL5bqP5peg5rOV6K+75Y+W6L+Z5Lqb5a+GDQo+ICvpkqXjgILl
nKhTRVbkuK3vvIzlr4bpkqXms6jlhaXpnIDlnKjomZrmi5/mnLrlkK/liqjmtYHnqIvnmoTml6nm
nJ/pmLbmrrXvvIjlrqLmiLfmnLrlvIDlp4vov5DooYzliY3vvIkNCj4gK+aJp+ihjOOAgg0KPiAr
DQo+ICtlZmlfc2VjcmV05YaF5qC45qih5Z2X5YWB6K6455So5oi356m66Ze05bqU55So56iL5bqP
6YCa6L+Hc2VjdXJpdHlmc++8iOWuieWFqOaWh+S7tuezu+e7n++8ieiuvw0KPiAr6Zeu6L+Z5Lqb
5a+G6ZKl44CCDQo+ICsNCj4gK+WvhumSpeaVsOaNrua1gQ0KPiArPT09PT09PT09PQ0KPiArDQo+
ICvlrqLmiLfmnLrlm7rku7blj6/og73kvJrkuLrlr4bpkqXms6jlhaXpooTnlZnkuIDlnZfmjIfl
rprnmoTlhoXlrZjljLrln5/vvIzlubblsIbor6XljLrln5/nmoTkvY3nva7vvIjln7rlh4YNCj4g
K+WuouaIt+acuueJqeeQhuWcsOWdgEdQQeWSjOmVv+W6pu+8ieWcqEVGSemFjee9ruihqOS4re+8
jOmAmui/hyBgYExJTlVYX0VGSV9DT0NPX1NFQ1JFVF9BUkVBX0dVSURgYA0KPiAr5p2h55uu77yI
5a+55bqU55qER1VJROWAvOS4uiBgYGFkZjk1NmFkLWU5OGMtNDg0Yy1hZTExLWI1MWM3ZDMzNjQ0
N2BgIO+8ieeahOW9ouW8j+WPkeW4g+OAgg0KPiAr5Zu65Lu25bqU5bCG5q2k5YaF5a2Y5Yy65Z+f
5qCH6K6w5Li6IGBgRUZJX1JFU0VSVkVEX1RZUEVgYCDvvIzlm6DmraTlhoXmoLjkuI3lupTlsIbl
hbbnlKjkuo7oh6rouqvnlKjpgJTjgIINCj4gKw0KPiAr6Jma5ouf5py65ZCv5Yqo6L+H56iL5Lit
77yM6Jma5ouf5py6566h55CG5Zmo5Y+v5ZCR6K+l5Yy65Z+f5rOo5YWl5a+G6ZKl44CC5ZyoQU1E
IFNFVuWSjFNFVi1FU+S4re+8jOatpA0KPiAr5pON5L2c6YCa6L+HIGBgS1ZNX1NFVl9MQVVOQ0hf
U0VDUkVUYGAg5ZG95Luk5omn6KGM77yI5Y+C6KeBIFtzZXZfQ05dXyDvvInjgILms6jlhaXnmoTi
gJzlrqLmiLfmnLoNCj4gK+aJgOacieiAheWvhumSpeaVsOaNruKAneW6lOmHh+eUqOW4pkdVSUTn
moTlr4bpkqXlgLzooajnu5PmnoTvvIzlhbbkuozov5vliLbmoLzlvI/lnKggYGBkcml2ZXJzL3Zp
cnQvDQo+ICtjb2NvL2VmaV9zZWNyZXQvZWZpX3NlY3JldC5jYGAg5paH5Lu255qERUZJ5a+G6ZKl
5Yy65Z+f57uT5p6E6YOo5YiG5Lit5pyJ6K+m57uG5o+P6L+w44CCDQo+ICsNCj4gK+WGheaguOWQ
r+WKqOaXtu+8jOWGheaguOeahEVGSempseWKqOeoi+W6j+WwhuS/neWtmOWvhumSpeWMuuWfn+S9
jee9ru+8iOadpeiHqkVGSemFjee9ruihqO+8ieWIsCBgYGVmaS5jb2NvX3NlY3JldGBgDQo+ICvl
rZfmrrXjgILpmo/lkI7vvIzlroPkvJrmo4Dmn6Xlr4bpkqXljLrln5/mmK/lkKblt7LloavlhYXv
vJrmmKDlsITor6XljLrln5/lubbmo4Dmn6XlhbblhoXlrrnmmK/lkKbku6UNCj4gK2BgRUZJX1NF
Q1JFVF9UQUJMRV9IRUFERVJfR1VJRGBgIO+8iOWvueW6lOeahEdVSUTkuLogYGAxZTc0ZjU0Mi03
MWRkLTRkNjYtOTYzZS1lZjQyODdmZjE3M2JgYCDvvIkNCj4gK+W8gOWktOOAguWmguaenOWvhumS
peWMuuWfn+W3suWhq+WFhe+8jEVGSempseWKqOeoi+W6j+WwhuiHquWKqOWKoOi9vWVmaV9zZWNy
ZXTlhoXmoLjmqKHlnZfvvIzlubbpgJrov4dzZWN1cml0eWZz5bCG5a+G6ZKlDQo+ICvmmrTpnLLn
u5nnlKjmiLfnqbrpl7TlupTnlKjnqIvluo/jgIJlZmlfc2VjcmV05paH5Lu257O757uf5o6l5Y+j
55qE6K+m57uG5L+h5oGv6K+35Y+C6ICDIFtzZWNyZXRzLWNvY28tYWJpX0NOXV8g44CCDQo+ICsN
Cj4gKw0KPiAr5bqU55So5L2/55So56S65L6LDQo+ICs9PT09PT09PT09PT0NCj4gKw0KPiAr5YGH
6K6+5a6i5oi35py66ZyA6KaB5a+55Yqg5a+G5paH5Lu26L+b6KGM6K6h566X5aSE55CG44CC5a6i
5oi35py65omA5pyJ6ICF6YCa6L+H5a+G6ZKl5rOo5YWl5py65Yi25o+Q5L6b6Kej5a+G5a+G6ZKl
DQo+ICvvvIjljbPlr4bpkqXvvInjgILlrqLmiLfmnLrlupTnlKjnqIvluo/ku45lZmlfc2VjcmV0
5paH5Lu257O757uf6K+75Y+W6K+l5a+G6ZKl77yM54S25ZCO5bCG5paH5Lu26Kej5a+G5Yiw5YaF
5a2Y5Lit77yMDQo+ICvmjqXnnYDlr7nlhoXlrrnov5vooYzpnIDopoHnmoTorqHnrpfjgIINCj4g
Kw0KPiAr5Zyo5q2k56S65L6L5Lit77yM5Li75py65peg5rOV5LuO56OB55uY6ZWc5YOP5Lit6K+7
5Y+W5paH5Lu277yM5Zug5Li65paH5Lu25piv5Yqg5a+G55qE77yb5Li75py65peg5rOV6K+75Y+W
6Kej5a+G5a+G6ZKl77yMDQo+ICvlm6DkuLrlroPmmK/pgJrov4flr4bpkqXms6jlhaXmnLrliLbv
vIjljbPlronlhajpgJrpgZPvvInkvKDpgJLnmoTvvJvkuLvmnLrkuZ/ml6Dms5Xor7vlj5blhoXl
rZjkuK3nmoTop6Plr4blhoXlrrnvvIzlm6DkuLoNCj4gK+i/meaYr+S4gOS4quacuuWvhuWei++8
iOWGheWtmOWKoOWvhu+8ieWuouaIt+acuuOAgg0KPiArDQo+ICvku6XkuIvmmK/kuIDkuKrnroDl
jZXnmoTnpLrkvovvvIzlsZXnpLrkuoblnKjlrqLmiLfmnLrkuK3kvb/nlKhlZmlfc2VjcmV05qih
5Z2X55qE6L+H56iL77yM5Zyo5ZCv5Yqo5pe25rOo5YWl5LqGDQo+ICvkuIDkuKrljIXlkKs05Liq
5a+G6ZKl55qERUZJ5a+G6ZKl5Yy65Z+fOjoNCj4gKw0KPiArICAgICAgICAjIGxzIC1sYSAvc3lz
L2tlcm5lbC9zZWN1cml0eS9zZWNyZXRzL2NvY28NCj4gKyAgICAgICAgdG90YWwgMA0KPiArICAg
ICAgICBkcnd4ci14ci14IDIgcm9vdCByb290IDAgSnVuIDI4IDExOjU0IC4NCj4gKyAgICAgICAg
ZHJ3eHIteHIteCAzIHJvb3Qgcm9vdCAwIEp1biAyOCAxMTo1NCAuLg0KPiArICAgICAgICAtci0t
ci0tLS0tIDEgcm9vdCByb290IDAgSnVuIDI4IDExOjU0IDczNjg3MGU1LTg0ZjAtNDk3My05MmVj
LTA2ODc5Y2UzZGEwYg0KPiArICAgICAgICAtci0tci0tLS0tIDEgcm9vdCByb290IDAgSnVuIDI4
IDExOjU0IDgzYzgzZjdmLTEzNTYtNDk3NS04YjdlLWQzYTBiNTQzMTJjNg0KPiArICAgICAgICAt
ci0tci0tLS0tIDEgcm9vdCByb290IDAgSnVuIDI4IDExOjU0IDk1NTNmNTVkLTNkYTItNDNlZS1h
YjVkLWZmMTdmNzg4NjRkMg0KPiArICAgICAgICAtci0tci0tLS0tIDEgcm9vdCByb290IDAgSnVu
IDI4IDExOjU0IGU2ZjVhMTYyLWQ2N2YtNDc1MC1hNjdjLTVkMDY1ZjJhOTkxMA0KPiArDQo+ICsg
ICAgICAgICMgaGQgL3N5cy9rZXJuZWwvc2VjdXJpdHkvc2VjcmV0cy9jb2NvL2U2ZjVhMTYyLWQ2
N2YtNDc1MC1hNjdjLTVkMDY1ZjJhOTkxMA0KPiArICAgICAgICAwMDAwMDAwMCAgNzQgNjggNjUg
NzMgNjUgMmQgNjEgNzIgIDY1IDJkIDc0IDY4IDY1IDJkIDZiIDYxICB8dGhlc2UtYXJlLXRoZS1r
YXwNCj4gKyAgICAgICAgMDAwMDAwMTAgIDc0IDYxIDJkIDczIDY1IDYzIDcyIDY1ICA3NCA3MyAw
MCAwMSAwMiAwMyAwNCAwNSAgfHRhLXNlY3JldHMuLi4uLi58DQo+ICsgICAgICAgIDAwMDAwMDIw
ICAwNiAwNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwuLnwN
Cj4gKyAgICAgICAgMDAwMDAwMjINCj4gKw0KPiArICAgICAgICAjIHJtIC9zeXMva2VybmVsL3Nl
Y3VyaXR5L3NlY3JldHMvY29jby9lNmY1YTE2Mi1kNjdmLTQ3NTAtYTY3Yy01ZDA2NWYyYTk5MTAN
Cj4gKw0KPiArICAgICAgICAjIGxzIC1sYSAvc3lzL2tlcm5lbC9zZWN1cml0eS9zZWNyZXRzL2Nv
Y28NCj4gKyAgICAgICAgdG90YWwgMA0KPiArICAgICAgICBkcnd4ci14ci14IDIgcm9vdCByb290
IDAgSnVuIDI4IDExOjU1IC4NCj4gKyAgICAgICAgZHJ3eHIteHIteCAzIHJvb3Qgcm9vdCAwIEp1
biAyOCAxMTo1NCAuLg0KPiArICAgICAgICAtci0tci0tLS0tIDEgcm9vdCByb290IDAgSnVuIDI4
IDExOjU0IDczNjg3MGU1LTg0ZjAtNDk3My05MmVjLTA2ODc5Y2UzZGEwYg0KPiArICAgICAgICAt
ci0tci0tLS0tIDEgcm9vdCByb290IDAgSnVuIDI4IDExOjU0IDgzYzgzZjdmLTEzNTYtNDk3NS04
YjdlLWQzYTBiNTQzMTJjNg0KPiArICAgICAgICAtci0tci0tLS0tIDEgcm9vdCByb290IDAgSnVu
IDI4IDExOjU0IDk1NTNmNTVkLTNkYTItNDNlZS1hYjVkLWZmMTdmNzg4NjRkMg0KPiArDQo+ICsN
Cj4gK+WPguiAg+aWh+eMrg0KPiArPT09PT09PT0NCj4gKw0KPiAr6K+35Y+C6KeBIFtzZXYtYXBp
LXNwZWNfQ05dXyDku6Xojrflj5bmnInlhbNTRVYgYGBMQVVOQ0hfU0VDUkVUYGAg5pON5L2c55qE
5pu05aSa5L+h5oGv44CCDQo+ICsNCj4gKy4uIFtzZXZfQ05dIERvY3VtZW50YXRpb24vdmlydC9r
dm0veDg2L2FtZC1tZW1vcnktZW5jcnlwdGlvbi5yc3QNCj4gKy4uIFtzZWNyZXRzLWNvY28tYWJp
X0NOXSBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3NlY3VyaXR5ZnMtc2VjcmV0cy1jb2NvDQo+
ICsuLiBbc2V2LWFwaS1zcGVjX0NOXSBodHRwczovL3d3dy5hbWQuY29tL3N5c3RlbS9maWxlcy9U
ZWNoRG9jcy81NTc2Nl9TRVYtS01fQVBJX1NwZWNpZmljYXRpb24ucGRmDQo+ICsNCj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3NlY3VyaXR5L3NlY3JldHMv
aW5kZXgucnN0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vc2VjdXJpdHkvc2Vj
cmV0cy9pbmRleC5yc3QNCj4gaW5kZXggNWVhNzg3MTNmMTBlLi4zODQ2NGRjYjJjM2MgMTAwNjQ0
DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3NlY3VyaXR5L3NlY3Jl
dHMvaW5kZXgucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3Nl
Y3VyaXR5L3NlY3JldHMvaW5kZXgucnN0DQo+IEBAIC01LDEzICs1LDEwIEBADQo+DQo+ICA657+7
6K+ROg0KPg0KPiAtPT09PT09PT09PT09PT09PT09PT09DQo+ICs9PT09PT09PQ0KPiAg5a+G6ZKl
5paH5qGjDQo+IC09PT09PT09PT09PT09PT09PT09PT0NCj4gKz09PT09PT09DQo+DQo+ICAuLiB0
b2N0cmVlOjoNCj4NCj4gLQ0KPiAtVE9ET0xJU1Q6DQo+IC0NCj4gLSogY29jbw0KPiArICAgY29j
bw0KPiAtLQ0KPiAyLjQ5LjANCj4NCg==

