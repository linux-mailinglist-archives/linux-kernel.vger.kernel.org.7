Return-Path: <linux-kernel+bounces-889879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8F0C3EC02
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2710D188CB11
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE63B308F3B;
	Fri,  7 Nov 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8Yy/JTb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBC22FB602
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500601; cv=none; b=g51FOxyz4AOzPrQoC/VkyhwmPBaefE0n8xVK+leMP18bo9uvqT0ic04RIhTVhj0Wg3wwu3Xwq+zmNAhelfxy2tmsS1qZYXH0d7z/1Z1zkfLMpXwHoRUGETpi9USlUTtpQEpGT4nVs6INdSPD1l9vH5InuPbEmRQI5Tc5sIcr+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500601; c=relaxed/simple;
	bh=0k/4QNOUemavZRM5AvbADrQGHF4kzm1DwuxWGRY7jxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpgg3wmPuX9wPDIx9OnnhPBXSrjg93hZPy0N7Otqy9NKc5zBZmkW6VhiVP+Mz+OrIHbMTyEpJIM2ZOGgD3/SJHv8KWrwBtttcnFrtqRiG5CPtuvNYPWW4CHWzViq15IjbhKBTQ6cbtNIis8jgCVtX5K6ulHDXVu8R+bT1OAC31A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8Yy/JTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3498C4AF09
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762500600;
	bh=0k/4QNOUemavZRM5AvbADrQGHF4kzm1DwuxWGRY7jxs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y8Yy/JTbkpMAQ+9glG9IYLNSC9wrSFSCznDVUsaXREztSmFbr+/WXEVxHsh1nfe3M
	 K6MrVhlkVfiqh+V1tcN82btGg1vERjNp4FTdKazMuyl+tVajODxxy6Jhh5ZgKFD36S
	 76jqEgGahcqU6fDwPLGpYVlRQ3vnM8xLFmKWLcqHjKuolqm7MCmvQtzst0h9tMpvYh
	 AsDM5LmeRVqNILFAGDIm2wCmSTLlBhV739b+QJXlpXh8x4s3oNM297Vg0Icd86TapM
	 kGNAlbIYzHrLnBybVPG07Rtpn5Q63qmewIyJV26K20WNVof03w9hn/A4hj+4GzxWbP
	 jqqTAA0QO0XRA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-641458f71ffso460819a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:30:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQvBvmYYxLQByvg4CPu45wEorMOsxvEi6Nls09vDKAGuilibZH4Qe5ZAM65LrAiv+DTS8a+8QEUmqLXg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfcC2ZvtQ/bk6YdHXuexHufFkP+DUqQ/+6husTOM968xxIP9mO
	c0Bp2UI7KqcFSJVdMusHZGIhVSMtQV93syD9tRxRmpuuBzweAQ8Mp7Sb5cKXNiOKq+lL+z1BrjR
	iUuxyPM/5EEysxwdyZ74V/nrtgT5D2co=
X-Google-Smtp-Source: AGHT+IEEqSEbBT2gOLAIiEzEt3XyHlCm/Sy7SKJj6NpY39BtIpvPnBcuZZkA9JM5llYlltGgdqDj+a8KBw9sRh1/yQI=
X-Received: by 2002:a17:907:2d2b:b0:b72:6728:5bb1 with SMTP id
 a640c23a62f3a-b72c0e986f9mr197926466b.56.1762500599010; Thu, 06 Nov 2025
 23:29:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <690d2bd5.a70a0220.22f260.000f.GAE@google.com>
In-Reply-To: <690d2bd5.a70a0220.22f260.000f.GAE@google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 7 Nov 2025 16:29:46 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8HxiEGLS4zBFEKAcxT_qtAFM8Ng0YKZ5seTnB3A_-RVQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkTi5Rpu8-GCzyy2Ci7sgiyDnxdQX0aAB7UMaQ0qYE_X1ORBuTvEUu7zdc
Message-ID: <CAKYAXd8HxiEGLS4zBFEKAcxT_qtAFM8Ng0YKZ5seTnB3A_-RVQ@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] WARNING in __rt_mutex_slowlock_locked (2)
To: syzbot <syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: multipart/mixed; boundary="0000000000001f42310642fc2655"

--0000000000001f42310642fc2655
Content-Type: text/plain; charset="UTF-8"

#syz test

--0000000000001f42310642fc2655
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-exfat-return-error-if-start_clu-is-invalid.patch"
Content-Disposition: attachment; 
	filename="0001-exfat-return-error-if-start_clu-is-invalid.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mhojbsdt0>
X-Attachment-Id: f_mhojbsdt0

RnJvbSAyNTg5MmU4ZGU5NTVkNzE3ODU5ZjAyZThkYTY1YzEwOTE1NmM0ZWUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpE
YXRlOiBGcmksIDcgTm92IDIwMjUgMTY6Mjc6MTAgKzA5MDAKU3ViamVjdDogW1BBVENIXSBleGZh
dDogcmV0dXJuIGVycm9yIGlmIC0+c3RhcnRfY2x1IGlzIGludmFsaWQKClNpZ25lZC1vZmYtYnk6
IE5hbWphZSBKZW9uIDxsaW5raW5qZW9uQGtlcm5lbC5vcmc+Ci0tLQogZnMvZXhmYXQvbmFtZWku
YyB8IDUgKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvbmFtZWkuYyBiL2ZzL2V4ZmF0L25hbWVpLmMKaW5k
ZXggNzQ1ZGNlMjlkZGI1Li40ZGQwOWRhMWFhOTIgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L25hbWVp
LmMKKysrIGIvZnMvZXhmYXQvbmFtZWkuYwpAQCAtNjU3LDEwICs2NTcsOSBAQCBzdGF0aWMgaW50
IGV4ZmF0X2ZpbmQoc3RydWN0IGlub2RlICpkaXIsIGNvbnN0IHN0cnVjdCBxc3RyICpxbmFtZSwK
IAogCWluZm8tPnN0YXJ0X2NsdSA9IGxlMzJfdG9fY3B1KGVwMi0+ZGVudHJ5LnN0cmVhbS5zdGFy
dF9jbHUpOwogCWlmICghaXNfdmFsaWRfY2x1c3RlcihzYmksIGluZm8tPnN0YXJ0X2NsdSkgJiYg
aW5mby0+c2l6ZSkgewotCQlleGZhdF93YXJuKHNiLCAic3RhcnRfY2x1IGlzIGludmFsaWQgY2x1
c3RlcigweCV4KSIsCisJCWV4ZmF0X2ZzX2Vycm9yKHNiLCAic3RhcnRfY2x1IGlzIGludmFsaWQg
Y2x1c3RlcigweCV4KSIsCiAJCQkJaW5mby0+c3RhcnRfY2x1KTsKLQkJaW5mby0+c2l6ZSA9IDA7
Ci0JCWluZm8tPnZhbGlkX3NpemUgPSAwOworCQlyZXR1cm4gLUVJTzsKIAl9CiAKIAlpZiAoaW5m
by0+dmFsaWRfc2l6ZSA+IGluZm8tPnNpemUpIHsKLS0gCjIuMjUuMQoK
--0000000000001f42310642fc2655--

