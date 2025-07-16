Return-Path: <linux-kernel+bounces-734370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0108B080AE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C305684E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945352EE979;
	Wed, 16 Jul 2025 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdApZz5A"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBFA2EE967;
	Wed, 16 Jul 2025 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706217; cv=none; b=hRf33Lu60R1TbCc91ljTPjwL1ny62u0dbNjWJ9+jwsKxG8YAUzty7pDAzR45C4XLuLEwHGiiZVYZdiny8GsE7XEILWVzA0SSdyY8Mw1HaFuOPgc4UZIFHxENaTBN12ibgH+nLeOTfMSkc6q+gh2m+8HbvYcx9EnxCW0fGOkBjGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706217; c=relaxed/simple;
	bh=VGfW1b163o/bmk0vuCJVz43+P2lP0gLVrXWVdf3Vg2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FazeOSc6HL2Jd4KoM7XyImZ2p9ixwgemBocmFSLgiALEKw7GRZlqfOnCONA/RtfjREaINRADYQTIhFuw9UPL9btmTUCXXO0xwNU3zgT/yA68pxBF9JLpntGV4jTGD1EZw3jExusjoGuiHCvkY5qdJqaRDqDIGFtZ3Lci0fuXnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdApZz5A; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b31d4886c50so49115a12.2;
        Wed, 16 Jul 2025 15:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752706215; x=1753311015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGfW1b163o/bmk0vuCJVz43+P2lP0gLVrXWVdf3Vg2I=;
        b=gdApZz5AZJc6nH6HOSU8v4/jBJQPUSPwjwLo0Xgdip9tcR1SsYZui5hn26L2X7RlBB
         FnAhYLs3magIgpDQPioo3wX1bcleDv0Q/08KJD51jdBw7O49kEc2g/NaZz916zO5QYz2
         i7ljAT7Cx1qMeUFjBYFHLiLnPyybJAi+i3B7UzyzKiKh9/EeltKxsREqV/8Y495Q3vHB
         TCJOU9ZIkU99vIOAiISQdg6qdQw39iGFTiS/raxleFi04M6Pd75r0NNKoEHu4UqSaGTK
         PkQD3UqlAW2RG38cdsgC/AaDpEWBdN/8N12fLE2egt/nL/Tz0JevLDMDfypBBta1noSX
         wRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752706215; x=1753311015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGfW1b163o/bmk0vuCJVz43+P2lP0gLVrXWVdf3Vg2I=;
        b=Jn/p7314ysTqw+u2zAXZ4UH6sy8Q8YNhKR9xhnj00vhlAEML6zR6F5AKykg0l8/pxF
         sZWr6gk5yFYceWFHinOmosxVmG33WbD8RSIEURgvzkW0Xck7t7Ds1EiLsO2OGcNS/Cjf
         5aYi9Xb4Z3xa574nyNL20Aqb+r0IDUeyu8BiYxrktmsjI5V1IJQyJ4pWqAAOXePPy/+Y
         RwyB54HTDGwmvo5TYCcE0Sd4XqlkIP3sjQ48/aqhnvqLBPKR64u/u+J5utz19lKQ14B6
         IlTo6O1S+TidtDJZYHvsMcKgawArGPi2G4ylG5yxmNhXvqiss/EYv4A/gVOr4FGyXIDs
         iExw==
X-Forwarded-Encrypted: i=1; AJvYcCVifRPee+6htJ8M0Zdp0Kn4zjjhUYT3n0L31zYBQmBjY5yhE4NUqLguWClijWazz7tEVRjzgXRQSMbM8aeKyss=@vger.kernel.org, AJvYcCVtdFIKuO8FqDvBKiga2EmLa7vzVMS4uyeumVwLNoCNXarcB3Awa6VmYiw/EMM9X6WW04adLzH+ISGKco4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNaqAdEx0KlMqCcwjSkoqZSD9ZOuBVgptcQWANpMUTOudikmB1
	UGaWkPu2eHVBUZrZMaQ0izotdyTak+/31pFw2uk2WrPoS2o+yplVtSa9D8RGvRWQuBHE1VTLrGm
	tc3RZvxRtqlpueJ90vnQAvHoHU30uvcA=
X-Gm-Gg: ASbGncsS92JHVMRUodpBvoIvv2Ft+LtMK4bSBYaRsZkQdQ88IPFehfnBYY5s7cO5cW4
	p/DjgryeEstUbHWJ/d/V6alxe28wU/QEX04CMpahrM64OXCCzyZy/y2a/yaSGlLO16wY70uJBM1
	x+vyd25rUchiK9sVVcHpCn2kRYzYU7YJPLPAkE1wvIPlpVRpyy/TYmsvk37Wv4Bw9t6CWzszWBE
	tTO6A==
X-Google-Smtp-Source: AGHT+IG5Z+fRJ8W2t4fa/a36mmLaxTU8BpLppbXFLnyWgohZej1ibLJCMSC+JjR/6igbPHO/gX8m3WMPtOyCm16tzLc=
X-Received: by 2002:a17:902:f547:b0:234:ba37:87a3 with SMTP id
 d9443c01a7336-23e24ecc5bdmr25671355ad.3.1752706214973; Wed, 16 Jul 2025
 15:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DBCO0KQERIT5.GS89BZ9LY4TM@kernel.org>
In-Reply-To: <DBCO0KQERIT5.GS89BZ9LY4TM@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Jul 2025 00:50:02 +0200
X-Gm-Features: Ac12FXyqv7LZlUjtj_1x2t4_1p9Q_Y8R5bMjLjzprWgI12VqkCYKLmE7O7k_BWw
Message-ID: <CANiq72nnpBvtB=Q0sg1aXh0VKpfENarNgveK8OXSa=VjAsdO7Q@mail.gmail.com>
Subject: Re: [GIT PULL] Rust ALLOC & DMA for v6.17
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 3:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Please pull the following ALLOC & DMA changes.
>
> All commits have been in linux-next for a couple of weeks. I did a test m=
erge
> without any conflicts.

Merged (yesterday) into `rust-next` -- thanks!

And, indeed, thanks to the MM folks.

(I see you needed to merged the DMA ones into Nova too.)

Cheers,
Miguel

