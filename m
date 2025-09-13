Return-Path: <linux-kernel+bounces-815215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070A4B5614D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 15:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8151C20F32
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 13:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263772EFD8E;
	Sat, 13 Sep 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="LGSlOP2H";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="F/zMMroe"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CD4134BD
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757771742; cv=none; b=enmN67C+2aFARtswq3uzsL/RzrWOrHOjGJ2Ac8UM42sAYYsUFe0KpJblDbrm/3qlc9jJdYbW5rdZrOcBcsAvsBt86PsMB1Sj8YCRgoU/bSOTPXkxU11bWV72JgHNfkrj+v3aw4Pz8shs67HSDEYL1iR4yqXoqNUuCB50AB2X3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757771742; c=relaxed/simple;
	bh=xRqFyFbobNlfBZE7lFvJv9Ad9kcSsMg9AMQ9wEbMKV8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QurOQtKPefQMrrrJguPzxSlaB8laLUCe/7LifXpFTnD6ikz8j9L3X9qAK4BXsSuIJpkKBaPxI8b1/1fOcbPw33xmZpvI6u9dJHplyXgxRKCnhX0BNX/D3MwzMMpfIsiuZvEYV3FXzM8tzqdTMeoMKsuk34rl8lW2HmQ1TWE2VjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=LGSlOP2H; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=F/zMMroe; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757771728; x=1758376528;
	d=konsulko.se; s=rsa2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=VqfvmRHEuxO9NpjvelkKGUF0GWJA3hdevKwZTAZOKIQ=;
	b=LGSlOP2HhEqZ35E6Yti2WK1A67orLvN2dkvyYCoJikgar0EgL0TAVg+P5z0paT1XG1/1stpUglgww
	 +8AxVcNNCtppvLvq9IlAb9pTFkAAxKwtIippuIO4EfYZs8qDteLSZ2S+f5s1s3I6oVjH/ZVLkhOr0l
	 9vbipnrbFfXYEsOE4AdwDKX5+6flhpHTXUcg/uxQyIQzRN07jtIcX/Mvw4AROx9x+tyNk3ExO+B2pT
	 gw7pFPIYa+6fotbHEQvLesNMkbVaOg1zKo3+/CY+WpFlqSKEeswqCCiue/pBsKdrFex8nMw1FHvyWR
	 AXqQaP4Ock4crGWzth99tTFlxBnxjWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757771728; x=1758376528;
	d=konsulko.se; s=ed2;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=VqfvmRHEuxO9NpjvelkKGUF0GWJA3hdevKwZTAZOKIQ=;
	b=F/zMMroea44rwTonlcUX/xsJv+9EB6im4MPMNcyat5f4tYo6VrKIWO6ufl4Jit3sShq2pgBDfHhqx
	 oVipukvBw==
X-HalOne-ID: 4cc0b88f-90a9-11f0-ae4b-e90f2b8e16ca
Received: from smtpclient.apple (host-90-233-222-218.mobileonline.telia.com [90.233.222.218])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 4cc0b88f-90a9-11f0-ae4b-e90f2b8e16ca;
	Sat, 13 Sep 2025 13:55:27 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH 0/3] mm: remove zpool
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <f3ufcsjvvxhi5gzw2wglkpedgyyi6tiaje7em3tbxkzhklphvh@sv3dbo4yba5p>
Date: Sat, 13 Sep 2025 15:55:16 +0200
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <98B3AFB0-EBD5-4779-A5DB-FFA6717E83C3@konsulko.se>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250904093325.2768507-1-vitaly.wool@konsulko.se>
 <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz>
 <1d42c513-cc83-4f08-a10c-cbd6206070f4@konsulko.se>
 <girukcvvzgbtkxt4aftfz3lw3glvf2qsof4mx6wf5perolck5n@vaxlrtaeuzw7>
 <dh74mr7bjtpzk7frviv6iqqno2u2b27p7jiagp2dtnsz2wrfhr@wlb5vqg4majs>
 <tbvushbdn7nzitey3uy6humdndd6247r4544ngqkds3cr447e6@prnla4edwxmk>
 <f3ufcsjvvxhi5gzw2wglkpedgyyi6tiaje7em3tbxkzhklphvh@sv3dbo4yba5p>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
X-Mailer: Apple Mail (2.3826.200.121)



> On Sep 9, 2025, at 10:12=E2=80=AFPM, Yosry Ahmed =
<yosry.ahmed@linux.dev> wrote:
>=20
> On Mon, Sep 08, 2025 at 09:18:01PM +0900, Sergey Senozhatsky wrote:
>> On (25/09/06 14:25), Sergey Senozhatsky wrote:
>>> On (25/09/05 19:57), Yosry Ahmed wrote:
>>>> I think Android uses zram+zsmalloc with 16K pages. Perhaps Sergey =
could
>>>> confirm.
>>>=20
>>> I'm not working on android directly,
>>>=20
>>> I can confirm that android uses zram+zsmalloc.  As of 16K pages, =
there
>>> was a way to toggle 16k pages on android (via system settings), I =
don't
>>> know if this is the default now.
>>=20
>> While I don't know what zsmalloc struggles Vitaly is referring to in
>> particular, off the top of my head, zsmalloc does memcpy()'s for =
objects
>> that span multiple pages, when zsmalloc kmap()'s both physical pages =
and
>> memcpy()'s chunks of the object into a provided buffer. With 16K =
pages
>> we can have rather larger compressed objects, so those memcpy() are =
likely
>> more visible.  Attacking this would be a good idea, I guess.
>=20
> Yeah I personally think attacking whatever problems zsmalloc has with
> 16K pages is the way to go.

Well, there is a way out for 16+K pages, that being:
* restricting zsmalloc to not have objects spanning across 2 pages
* reworking size_classes based allocation to have uneven steps
* as a result of the above, organising binary search for the right size =
object

This will effectively turn zsmalloc into zblock, with some extra cruft =
that makes it far less comprehensible.

Another option would be to leave zsmalloc do its job on 4K pages and use =
zblock for bigger pages. But it is not possible at the moment because =
zpool api has been removed. Thats=E2=80=99s why I NACK=E2=80=99ed the =
zpool removal, at least until we have a replacement for it ready.

~Vitaly=

