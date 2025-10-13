Return-Path: <linux-kernel+bounces-851202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 825D5BD5C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E91035155E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F09296BDE;
	Mon, 13 Oct 2025 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w5tymBBf"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46C2D7381
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380897; cv=none; b=Ha6Ih40Qnav6ghQXKUPOTTP3t4TfxPf0y/6q0xSLxSHiLaJpPMJSlG/9fwscbPa+Kx6OW81gv/edvQ+S6Ire9a1jdlvfMOwYYPUSV5LjRpTD023GwVVKRoWxCQZyqBiik6CI2tvjIGceuTJHQTEBKFZJt+2O7N2IVqdifpQzNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380897; c=relaxed/simple;
	bh=iHfqM03svX+oQ66obSqo+eRScW0vFuqHkVSUnLn2398=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdQ6m2TN9oc/pdvgl50cnODVwg8mHnZ9eovchcSyQZqsLn8BSMciQIxCE9iAv1rz8WMeYMiOpPuxrKjGtmXZyxvXPTOUSkD8YN1yMms3r8PJYkMZlIHOlhEhs44EA/18y2oMaAytQl8F08lPyJyDeBkdgjqYv6+23idGN7UEzWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w5tymBBf; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so24699a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760380893; x=1760985693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHfqM03svX+oQ66obSqo+eRScW0vFuqHkVSUnLn2398=;
        b=w5tymBBfENAAYOJbrpESjxEEnYBrFspQtO6lya2gBf0ylx1B/FqoOVOTBfPe60zayX
         0SKhYlfkUNLx8u+t6licarE1ywGdVBZR7O+bh1gxRKs1qBedRKQNJlu0fosTBVnNHpES
         4JcPwfqgSsCBa8Kd6laQYAScvPZCcJo4xWxmLjAPFatCGu0cK0RcvxgXtlRaN6sJYBw0
         2CeqIfP6Q8tx6IU+WVXyYjLqsGR1qNlMEWYKhv3mdBlnDFPO1Ytt9mt8It+aW5A5MzQV
         DuoV4Judew7/7WAKm6N/+fKPX/py4lBgetGfmucEj5Ttpz9/RJ+xNBW/8u8+alhYGIaG
         CuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760380893; x=1760985693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHfqM03svX+oQ66obSqo+eRScW0vFuqHkVSUnLn2398=;
        b=KPg3Hf4ieg8XRoj9fpqaLEoHHu62IuJts5YmMhq4iYf2pu6424GiutHKmyQkjEQ4I5
         B1CVkq24E3gErmuHG09Yoy65z9NvNjPCbOHQdaI5ksE6Bsn42kNEUHdTgTxHWl5jzaym
         CW0jPfHCBREoUvv0sUK4Gp0FhEHJiKX1RHUbGgBrvAbiaS0MHrZaWdMcZ6zuFfR7DQNq
         T+6v7FUAmpsHibCEpcUXnl2oULZyJkDp7Ajn1EyHWTgkMP21daVvTW7ryuP1Gv4as4rW
         LjMzkgLiBIhlA1wQP3bykaGiEKKX5OeJFRcOkuk2RU3yWopQWYac/usIZzMShtFVopZ/
         uR/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqJpFDODpxa/rCtB2+FWwQCF0PlU5liIMr+NWZicU///pff2ycuHnFLFNfpfgC7vu3bEobtJEjLwP5bn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyynHDfO2QeM0gWkFwvDoS9Mt5feGfpwV0HVmO8x2l+6dxCuA4g
	R0uqH5cms0eJOdz7GqPTDQkCMs7wlm0AmGv1lYCejDkyTvoSL+PbdFjleOubHzAjw2Br6lU9psT
	pLA9kbM7IADvWnlnKPXzZkGAL2ntvF/+GlvrCnzso
X-Gm-Gg: ASbGncuPYeaOrInciyhSjSOa1N5/+7rdBeal2+T0WMT0+MiklEZf7f38MbwWhqzzx2l
	pJ4OyoNCMjqxnn+PJgxWNzjiAjdR49eyy8teT6m23esNjF9HmtZFWG2Udby4JY3pSOlstwQ4oJA
	IkYSPc7vU1BXWbbj+ABAYUmCiA/iVToZZvkzld5mEQOIov/uUtbY4bACfU4bv6DiucC0GdxhS3/
	9vY2cAAKJPMEfNIN6t6T1S2naps78a3RSCR7SbbK1I=
X-Google-Smtp-Source: AGHT+IFbmLphFAx+O5iG90iX9HogRPWUiCByGZx68PKNe1ZloAu/b3Rao00A/sjzsen7DJqCgwzu5gI+Pcc4So+lDH8=
X-Received: by 2002:aa7:c397:0:b0:634:38d4:410a with SMTP id
 4fb4d7f45d1cf-639d51d0407mr545062a12.2.1760380893401; Mon, 13 Oct 2025
 11:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev> <20251001145816.1414855-10-yosry.ahmed@linux.dev>
In-Reply-To: <20251001145816.1414855-10-yosry.ahmed@linux.dev>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 13 Oct 2025 11:41:21 -0700
X-Gm-Features: AS18NWCalgoEMzCEfvMZw9n2fvq5F7tQ5ti-oUsJw3mE6SvX8KE83Zr7Sx3VYNI
Message-ID: <CALMp9eQacZ-hE3ePmWy2-ct1C56vs4FKR=HnFj8-=Tc3G3NVPQ@mail.gmail.com>
Subject: Re: [PATCH 09/12] KVM: selftests: Move all PTE accesses into nested_create_pte()
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:05=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev> =
wrote:
>
> From: Yosry Ahmed <yosryahmed@google.com>
>
> In preparation for making the nested mapping functions work for NPT,
> move all logic that directly accesses the PTE into nested_create_pte(),
> as these accesses will be different for SVM.
>
> Stop using struct eptPageTableEntry in the caller, instead pass a
> uint64_t pointer (and add an assertion on the size to make sure it stays
> correct).
>
> Calculate whether or not an EPT entry is a leaf in __nested_pg_map(),
> and return the address from nested_create_pte() to __nested_pg_map().
> Also, set the access and dirty bits in nested_create_pte() for leaf
> entries. This matches the current behavior and removes all direct
> accesses to the EPT entry from __nested_pg_map().
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Reviewed-by: Jim Mattson <jmattson@google.com>

