Return-Path: <linux-kernel+bounces-851233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E330BD5DED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12E918A518E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B9D2D781E;
	Mon, 13 Oct 2025 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iByrEsah"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E82C21FE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382263; cv=none; b=Q3sYXNcmwmTVIiaw7MH4G8aOOwEQp24XqjNmAj0u+ihiWVgk6a56GGTzEP7jfLYxENVBRhBicS3BICswTVt/AGbCMIUrj7n7eZmZAoV7N8iBUr/WMnDobPCMn/DjlfNgaYXPi6SrE2rL+H11EltuO+jwz2kz5uSFBv1adDy9A48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382263; c=relaxed/simple;
	bh=XRprMW462hmHGXXZD42eydpn9MCzdLT2QtgbxxPu/vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoEpKMppkk+8zIpm9o3gMqplxms9d7CcTsqjhft5Jw/yIoLtUo4O+j0DUTbF9OIOS05ZWwSmVy+R8wRWaEqU+XuK83QsnIghpnDJMpxRlaFI+17L5vMhFL3jmWOJs97xZj9dCPOT7Al3fjYFYT9J0c7CL9db+6LgxTyLIoyE4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iByrEsah; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so22859a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760382260; x=1760987060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRprMW462hmHGXXZD42eydpn9MCzdLT2QtgbxxPu/vg=;
        b=iByrEsahQbs7UlwyCh/9hoiMKrUooAmgLYAeLVllnDCWSv2/xb7xNYf6t8SNcm9igs
         uAZ79gjPZ5dp2Q6o0Zu5RQtytmpA2nCf8c9FzgUBHPTTOpAg1X8HmOLSYtUANS9QFVVv
         gN9QvYliTPFsmnaS6KuZAWDzE34EARFXp+uwckZVYdDYVWTen3OVC4UWrPsrqVrKjHye
         UuGu87LU/7yhErWzrOJXjikWeUGtGmOC3DtaRq7F/x1G2gyhTe4lL1El4wE3Baw2LyGL
         l3tr+TlixfvO11ivYSxeG0XTvvlqXgBhPTleE2iWU/JGgPoqbLp1uZfOL8A1SkIh5r7c
         MBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760382260; x=1760987060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRprMW462hmHGXXZD42eydpn9MCzdLT2QtgbxxPu/vg=;
        b=Vxlz1UJJOsnWJ7qkovJ1HKtmbYN/ZJwucDAlQp6Oc8l9rKXOqxbzJQXZw2MrUPhIG+
         4UEbeM2kQIpDl/BeNVXLu1BD0YpmfFK7Jb+EqOi+UOWJL1321H23T691lIgzF/aIFsCM
         Uvt6cTHv8eFrxYR4IfCLfjsneTEn7QF9DyDaSj5zv0uTB6ICjwpP63LC3UlFuif5h7Id
         bRSxWLvTZG3AmAI5LmlXLqUFEs7b1Nsw5N9NBgJSc0esUVKoRsdAVwQaYN+gw/aQy9kc
         8uSSZwAnWKjBtWnspTzUQygiX6fUbeWT5TIumbHFicWtYp+Lwb416Do9U6/ovrvt12nT
         gU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0yiSSmQfkMUY/RvsbVghf2Xqa1IinuRD2OZep04AR24H0DdCw2w+IEKeWmDQ2hlWq95FlV7M+A/2LcOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJHS8PW0PO7UvVmhb/Yl57nn1wBBKIUVP+EBvOW77aYEEIsPk9
	Ht2cPwNs/a2NnSp75YDq5ph5E8S1QfQKBbDMj7m9IZrNq2uv36JV8WvC+kPnoNsA1HI6QjSApcc
	1yU67yew3McNLVqjnhSClviyssltIw3FYC2aZ8Qyq
X-Gm-Gg: ASbGncvoUEwLipV70xvI5/4L7bDWkqbFYI+1rIIZ0tsQXJUCZoYeexfwFyfP7JNMWJT
	Amp121bOUqWfOpEbTCut9KIHhu1j1qTCHTL3nAu1VmOYzUyDmW+U0DdEL7ygSOJQdmAekwUz9K2
	znAG3qeUH5Jv/DkOWLdzNA1EHpQ1kYZjXlQLyRmoWpbVolijr/0BsSOCmWXKaQs4Ntit1e6NLjP
	ndctwSepihEocI2/0RXnDBtIyy2u9TJOzaMw6vYm3c=
X-Google-Smtp-Source: AGHT+IEYSCXvyAa4onFHDvb+igHl24Iib2rcrPd2zbTby8fnqVM+4LZBGS3gOAA834s4iEnNXAU4cjvH9SEmKADpFLg=
X-Received: by 2002:aa7:c2d0:0:b0:634:b4b5:896f with SMTP id
 4fb4d7f45d1cf-639d529d170mr631558a12.4.1760382259992; Mon, 13 Oct 2025
 12:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev> <20251001145816.1414855-12-yosry.ahmed@linux.dev>
In-Reply-To: <20251001145816.1414855-12-yosry.ahmed@linux.dev>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 13 Oct 2025 12:04:07 -0700
X-Gm-Features: AS18NWCV6dlj0kwQollJoONTn_dKeR6as388hv6aq1RgEpIeoM7iXJJUKnuNKLk
Message-ID: <CALMp9eQH1y1rfey6kCyOZs4uBmrRZKhEPLP50i22p5-Bhvxsow@mail.gmail.com>
Subject: Re: [PATCH 11/12] KVM: selftests: Refactor generic nested mapping
 outside VMX code
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:06=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev> =
wrote:
>
> From: Yosry Ahmed <yosryahmed@google.com>
>
> Now that the nested mapping functions in vmx.c are all generic except
> for nested_ept_create_pte(), move them all out into a new nested_map.c
> lib file and expose nested_ept_create_pte() in vmx.h. This allows
> reusing the code for NPT in following changes.
>
> While we're at it, merge nested_pg_map() and __nested_pg_map(), as the
> former is unused, and make sure all functions not exposed in the header
> are static.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Reviewed-by: Jim Mattson <jmattson@google.com>

