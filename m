Return-Path: <linux-kernel+bounces-845678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1D1BC5D06
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89127350B86
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38181220F5C;
	Wed,  8 Oct 2025 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLqhv60k"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340217A30A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938365; cv=none; b=D+2KDX2+NpakPF2SXhLuE3erUgBmqYl4QwUQbzW597Ig/T5TiaZn5JeH+AfWTSSsdxK6qbelpfSITXqqGLnGsVjbRxATbyLVTzRX/akQ9kCCl0bScWPe5IyvyOUxWorkizDf7d3K6Hx3xctZTW/bV1/SsnoUjl1D6oFXh6D+Cf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938365; c=relaxed/simple;
	bh=jtCWUN9qKHv9+z3G9i+tyP1pYkaMZxiy3AmNabxncSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h98Obe4Q7V68PbZkrTkxwcItpZbuk67iJWfDGgvaiFrFqpacWyjtsmWlNKxrz0d6yaRWQwk9qrw4J7B7GWRxnePnDnm7cCOsR56gopgRVa/3i8fsI2ZdHo6kgPUapqBEMUgDQOp5lHQuhfE6mayzgHQuynAfYKHK8B61e8bSxiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLqhv60k; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-92790f12293so362445139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759938362; x=1760543162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyHmjI+Pp+1EZQYG4RmZ+oWmdMUJujz0MvnC7rq6UVA=;
        b=VLqhv60kg8QpX6zf3sdqbw6ZOJGas8u1ShxuCEpQw0Y5dRI5AZzZsx02vUxwB3bD//
         BfQWCusvCwQr9rYfH/M+yl5WbF3/2NZtH4qyYSzYcCLCniwu190cuMs32tWT5zgV7Ey8
         sBsWrNPvhS/1pFVJr7IN2AMVT00qa5TY5rRLsNsrwwO9soaw2PsMvuVv1ezvmdFn5MUA
         pAcHxhsnZB22xRUPy6TBkWj9kJmuD+n9H/BHvjbOLNMdYtPrqNAXFHpJ3/FFq5RNt5rF
         NRI30Pjf2ZWVuNGX3QeSxVEoBvoK25UCTFAj7D68pLJTQZ3DFVqoigcXMbYa1yZGYLde
         VIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938362; x=1760543162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyHmjI+Pp+1EZQYG4RmZ+oWmdMUJujz0MvnC7rq6UVA=;
        b=kvey4kBNOcnw0XwIByKGwyUi9agApVGBonfTeg6vnUiKFpfvAWjFIHnZNMxgELTD+Q
         UXPfU/mmCxWJ+C/NLeDZPFRIxExX9P42jIF00p35COUbUfZgXlyT6Bv1kP5RU4EorfvZ
         1mZRk3Abnn5WB+UjqeWqXe/46AaB8Dk4tFSZNfrYviVP9o8XNhCpDQaJyC1uV3BgxfVg
         rmk2NbPHfe6L5g2eRjt2WDJuBk9oDElGhH1STusYILLh2PDvM7SoPGl6IM5oHGaRnucq
         4aVTh4PynZ7ca1W8e61olSQ89XcKKBWGFylVM9aOKAw2H+GOIAZiqesuS3qhz2U2NhJH
         1Eog==
X-Forwarded-Encrypted: i=1; AJvYcCUiXtWS5tPUmksvBrWkAdO8Rg3z8/b/rUHEzCyqGfCTB0kTr7fN4jBTEwirAVRKqN+rJA9K/bz7PKTtuqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ+JRNzapQyCNswnX7T1FoWZUHezrDjCxPFQFLnbL4UW4ndSV7
	gn+rRNFzF7K5txz8Uv07Cty+bD5FZx1j6yfIl3X+JHj1yJd2ov5ZqFygXuDE9AY3SZOyVcoDUnf
	v1uo9tJDe227rDkdqcsMv2tSYeqUqLdM=
X-Gm-Gg: ASbGncvxbFZaosvBb5DsdlmtrqO7GLkTRnPodtu8KmN3ptv3vv4eeDdV/5hwNLhOLX0
	8WMDkwPfazAb/jYCl289jRPnsvcpzidS0gk8a6kMvMuucAlkBgayQtQFu8bT5qn5QkasK2H3F8b
	XQozzuued3HMBz2n66NW/4xLqqZ6Jh8cKKN6bOIrYDobpkenvw4GfxubctdB1Qk8YTwhOieAru9
	aHtAU+GUjfiYrhHoen0h3drekBx
X-Google-Smtp-Source: AGHT+IFDpgA15TDMxrEIdhDPUBzLl6q8kmft2wJ5V4tEM840WRm8RlBVABfwKbO7llkfJMYpVHKnB9gld3VrwW2meYE=
X-Received: by 2002:a05:6e02:440f:20b0:42f:8e88:faed with SMTP id
 e9e14a558f8ab-42f8e88fdd7mr8430765ab.7.1759938361936; Wed, 08 Oct 2025
 08:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003203851.43128-1-sj@kernel.org> <20251003203851.43128-2-sj@kernel.org>
In-Reply-To: <20251003203851.43128-2-sj@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 8 Oct 2025 08:45:51 -0700
X-Gm-Features: AS18NWD8AQK_m0J9OQQ2568NHQvCpLirccXoMfHk6y_3-THO678-BMip4zWDvSk
Message-ID: <CAKEwX=NOr96gbdEDJR8aTkwPfYzObEBq6W3Ow4-e8Q5k=v__MA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/zswap: remove unnecessary dlen writes for
 incompressible pages
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 1:38=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> Incompressible pages handling logic in zswap_compress() is setting
> 'dlen' as PAGE_SIZE twice.  Once before deciding whether to save the
> content as is, and once again after it is decided to save it as is.
> But the value of 'dlen' is used only if it is decided to save the
> content as is, so the first write is unnecessary.  It is not causing
> real user issues, but making code confusing to read.  Remove the
> unnecessary write operation.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: Nhat Pham <nphamcs@gmail.com>

