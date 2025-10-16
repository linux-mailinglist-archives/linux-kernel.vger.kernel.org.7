Return-Path: <linux-kernel+bounces-856973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF86BE5907
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E1114E58B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBF32DF3FD;
	Thu, 16 Oct 2025 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2QdmWmX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819D841C71
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649886; cv=none; b=hKMKlMPNab3FL8qUYzGbMc0ccPuEhblHB1i3KJgVsoI/VJQfdDcrGvgi0IzwpVxR6sPUSUDBHZiv2d5Fg0ulWMw/iWIJfmRDcroV2Ze15Ih92snnU/GnqbPZgP/h4bquUtETMbN3xWHELe5LkMr3UWblokruAk7PMBQixOLXOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649886; c=relaxed/simple;
	bh=GjJ1WmiRmWmpJrjA0Rajn65qwKkQDgHPux/O/uor8Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2/U4Yr9ZgV/kU9kQqwHor2VFXY0yWQS8cGPuRO069wVlrEUjTpN04iiWuFCRWgAFwT+RihUms6ySHujm0mDqo9irnmUo6oI9ADjxL0rYM1HdP05X4fe7mqqys+coxg3ZwvMJDogdkFfz61mNe4w8M8+7x6kBlJqcxVjmov6Jcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2QdmWmX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27ec3db6131so1891935ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760649885; x=1761254685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nrKPmUCwMPDYDiZh+SWdu6MfHF7qH9Oc5WdLHC9FKQ=;
        b=g2QdmWmXxegpgkzJSBhaldKE86gPX/kLptJHGVORF0aLJvz+oXQwRzUWLFWaXG5CBB
         amUm8j7Coh4+Tl1Onjj8ndL5znvqQTl5YaxdEsYbBwjU9A1+ssU6vU7i9/AYaBUVkq58
         Be/YxZpsuNmvWgEfg/tUOO4D4WJf1vH9LgUw9/oQw9V1+k8dvxrwCVS2eXB/xa4QBEjr
         C39A6UNqJOy8AwVDTk3UVXOZo7vBoe5FCiaMRiw5SUo8bTWmC9Q2ZzrVSjF7Xd/L4PbC
         UfjUrOPtHjrfc/I9i0JZG1Tl+sCqpCrjurCoDZyxHNVlnQUAguxnpWRR8IZb+wO2op2i
         lW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649885; x=1761254685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nrKPmUCwMPDYDiZh+SWdu6MfHF7qH9Oc5WdLHC9FKQ=;
        b=VUBH/hCKh4y/9hI/eDAnmU1LdgIksJiZYPWBWGE2pw2PXzNzaagqm1Ck0S/RgB83ME
         GwM7fEapj1DKLhUF84WDqW5D45qGEkojaRlWeShMVpHj41c55wYT1B5DeFqykbwn6m0j
         egQc1AtlegCEcVoJPs/igGoFchfujU6xOG8C+N/tRmCLH94Tk4ZdecNiaWDTwMeNUMVM
         nIgy9WBVjnfEmSJ+WKmQcY6htNaybuyo1pMkVoxKxxwuAHYQBoDXtmXjl1GkEj9qHPEd
         ODP6FwuOYs82FFUQY7Uv3+02ksiww0fkH7vIijkTg9R9c/UV8+dkRGgeLVuT0PuT+4fp
         MU3A==
X-Forwarded-Encrypted: i=1; AJvYcCXnSZr+/6VAn2Pyp9X4p17rDzdz9jrKfbjHrHTlgbzFHksPkDCW9WRu8VgAFkziNjxu5GuXrZBMjBNVP0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnpUTUvW3NlFNRoBjDw/rYuUd0ADkkgQRjMzm+GVfNoyW73479
	8jVUNt5AOp4X1aKaG69/Lb86CzcFL88+Y2VrFe5fcW115cflGIdBXm7TwERWE5hspX2iV+SfR0e
	JmE7NT4jqazR+tso86+g11gKdFxoUkj0=
X-Gm-Gg: ASbGnctgR0VRu0WvsYtH1oCSjDmRVKV5Fvv38ueZKlU+zgXCC+fs8gPnlkEAwfAvCAO
	7PeaDFuAs7be5udAUZFJE5WKRhOwYpVVTqKFNFhPH4+gXdcnhmm2hCqy1rtRMzNFEVHue38dCtS
	zXuvN0J0MEvxul3LOZ8Jq/9t1EXRPIXnq6I0zDdpZXt/aXStjw5QaEwE/93ZIRVF8uaYjbrzOkT
	L7A9enbeA0HB60RXoE6g75jOAAn6aaRgV6aQQ0MmtB90JIlX8Cqq69RaUjzOJQrln185sEXTfsa
	BnhL68tzoVCKSdQbTmf3FrhluwqbOKiuAGXO8P9iD1IQBoLGI14+LEBZUygpp36xmpysJYPWLkX
	P8RElUndXayidsw==
X-Google-Smtp-Source: AGHT+IGnxgBRJ3U+G+Rx7edjM57XlaxeOMOXI3o5gi2a34CPb9gCivHNo55oa8Ovom5Sgq5XvaFoCPqdKPPRGNcGOgk=
X-Received: by 2002:a17:903:19c8:b0:273:a653:bacf with SMTP id
 d9443c01a7336-290c9ae1dc0mr8912775ad.0.1760649884726; Thu, 16 Oct 2025
 14:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016211740.653599-1-lossin@kernel.org>
In-Reply-To: <20251016211740.653599-1-lossin@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Oct 2025 23:24:32 +0200
X-Gm-Features: AS18NWBqY989ayloddTfcF8OWEnJ9InCFTkCC88WD09zgOYwhDkhIBRAyogFVX4
Message-ID: <CANiq72k8KmpFyKAFZ293GDUWx5=HJtksR02hTU8-H9PX7xsT+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: pin-init: fix broken rust doc link
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Alban Kurti <kurti@invicto.ai>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 11:17=E2=80=AFPM Benno Lossin <lossin@kernel.org> w=
rote:
>
> Rust 1.92.0 warns when building the documentation that [`PinnedDrop`] is
> an invalid reference. This is correct and it's weird that it didn't warn
> before, so fix the link.

It is because it is hidden -- I have patches to fix this (it is not
just in pin-init but elsewhere too), but I am waiting for confirmation
on whether this is actually intentional behavior:

    https://github.com/rust-lang/rust/pull/147153#issuecomment-3395484636

From the early reply I got, it seems it is not, so it may be that it is "fi=
xed".

Personally, I think it is useful, so I hope they keep it, even if as a
new opt-in option or similar.

Of course, we can land this patch since it does not matter either way,
but please add a note with the above in the commit message if you land
it.

Thanks!

Cheers,
Miguel

