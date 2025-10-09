Return-Path: <linux-kernel+bounces-847536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD8BCB20B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE27481EF0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B52283CB0;
	Thu,  9 Oct 2025 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kWOqO9jd"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D0D286883
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049660; cv=none; b=W3vQXBUEgZHE9wWtxyvUT8QfU/WCKijy3UgyuDiqE3wm3NjgBZnmQiqd2db1w8BWxMjzkbBFFb7bPwkE1pCTE7n8LcORUuSr7H/wvGlTLtvy4J7TTumFn6TDXSMIwxKnxG4NalrAVLJBicwG5nx06ey/jsdympzGc9rUK1teKsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049660; c=relaxed/simple;
	bh=iHRkwjZFmsgbGZZzOocWcAK7uAsaUtkHpRJuDecbgAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3vPtwsQgQm3NLKXpOME58wRT2wHJTNqLHvwe/eaI8P9Wkobn8gZZkiPElONrJEphYebKUs3FnrwHQXP9VETSX2UlzOpUev9joQsBGA7VZ2k7eY0fvQix00db/ImGb7dFhqSt9X19JAtc7XX71nBE3eEO4WWHMfi84sMaXV7+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kWOqO9jd; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-633c627d04eso3628a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760049656; x=1760654456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+yH0NA0xcLeoUzm7kKblyD7A4cYDfGhXJpCuB241zQ=;
        b=kWOqO9jdBNaDQWxdpD1Jzsrr6vL8xpF8EfnwiLBCNRr5NUct9D4YR+5l2HrbZqF3QR
         tp4p9SDOsbtmSW1zylvYJrr4fxQSe2N13nRE13gifOYLKdyy4KwTw+7D2R9SnZN2VDFE
         jsY5vVeDSrW1iWyXZQRNYeqIByU0EsqNi+8Km3AWjxvxF+0N4iJLNwL+siLoPWkkn95v
         34wDQgkxEg0+4s4jPJVSdGoxs2zDojS6AImBKGF8aYlzSsHkCS0Xmmkl2G8s+SE/0LU2
         ZzxagTJA5eMZuyVH5bBIu3Tn1lCPMfRZhZaZExiz19epP68XIqHnzBw+uN8cHPGoReV+
         xS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049656; x=1760654456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+yH0NA0xcLeoUzm7kKblyD7A4cYDfGhXJpCuB241zQ=;
        b=KVH4rHCQINcz70HBkCKpLm5gje+U1sz7x3gSmRznm4VS3U75RzoytOquVD7AwWnLDW
         aXpvXVUu1q13yAVe5V9rEFPWHzNySbxIeC4G6D1Fe/J0p2hzsRJdNaqz1dQRZE9oArX7
         Ckw3HUfb/iAFGDbItHUCcv3e0Xixm3yDftkhDTeX+cuGjm2r8S8+ksU1ianqhezDwtPK
         BLIgJsEwEUU4Z4D2FHRNw0eVcYBu8Rry+HzE6/uFri0cqhhxqnra9k97traXXmXYuG/G
         Vn7Rtw4KWKbvAzlBPMwJkKY/kPBm45Oqw47tim0Je4352w3wXDg4fDbRdytHcwHFVAc8
         RFCg==
X-Forwarded-Encrypted: i=1; AJvYcCWSeVhAKihEynHnZH8bn6ruxFt+feG/nV9EvBb71VpjBPo0KWDzrgqLkeheEp0W6LAuDpX5Umv+WyhdtX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtu+8UTfTE1j4i9BRLhITaAYWnjbY9BH6v3wFGxUOzTLj4XxNH
	FJoU4OSf+s3FNGTksgQXSjNkBdnS+VOXgvnvOwOYcfN9NAsO+82Ayf0GUapsJKiY90d9ae6j5xG
	wY8lvW31cEktsiNBnO/yhueTLjhp8bEytFr1f+jhF
X-Gm-Gg: ASbGnctJHKFRoOeVZz5VRHunpaZVFC+noi2JfCJXoBsSpbeYJ8guXZocYLJmW/uwmIk
	zwA63KzJNve6+Gjd5B5Otk3cjSwC3JqZUJTZ/uWLJVpNazL7DsrYgS4TGQaF+M34oEAFbanEJqI
	bjKlZNbyBHIWlbe+tZJy/MWpvFPETcDZa0/cUeplEN/Jf5wPjwKQcrn6Ra8tp7sqxkuRouL0NZX
	GOz0Fl9uGWKje2bYLsZ7N3P7Cdo089dsDWF1ehhg9TiGRpr
X-Google-Smtp-Source: AGHT+IFMM1arzendIaoMvMcuHn77hUD6Cz9k4obCkd7Pd1UFiRKLhkp+8wOJGZxP9+89FENelDIu1jZMTZAZS1MUY/U=
X-Received: by 2002:aa7:c602:0:b0:634:ab12:83d4 with SMTP id
 4fb4d7f45d1cf-639d52c4caemr298350a12.6.1760049656367; Thu, 09 Oct 2025
 15:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev> <20251001145816.1414855-3-yosry.ahmed@linux.dev>
In-Reply-To: <20251001145816.1414855-3-yosry.ahmed@linux.dev>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 9 Oct 2025 15:40:44 -0700
X-Gm-Features: AS18NWC2e-ck6-uSYkTGFpZGqTrjbtjUd68e3ZwQCkjFl7PBxVXuoTR0B7cFVUc
Message-ID: <CALMp9eQi15V1+5EqCevm9aWMv4OAGbUb14dazBcjhhL8mVGHww@mail.gmail.com>
Subject: Re: [PATCH 02/12] KVM: selftests: Extend vmx_set_nested_state_test to
 cover SVM
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:03=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev> =
wrote:
>
> From: Yosry Ahmed <yosryahmed@google.com>
>
> Add test cases for the validation checks in svm_set_nested_state(), and
> allow the test to run with SVM as well as VMX.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
> ...
> +       /* If EFER.SVME is clear, GIF must be set and guest mode is disal=
lowed */

The GIF constraint is not architected. See
https://lore.kernel.org/kvm/20251009223153.3344555-2-jmattson@google.com/.

