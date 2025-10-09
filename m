Return-Path: <linux-kernel+bounces-847543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A30BCB25F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFB1D4F9AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14B8287514;
	Thu,  9 Oct 2025 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jAy7spK8"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13A280A56
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050288; cv=none; b=aPNV9xvAuIR+BZCsUlg0cT/ojLyy6AorVOFR1WWWZ5rQCs+TzjIavYef1yN0yeB/9pn6zQR8LRQA9Ecu2X0b5zn10IbJSKZ1/JDwhZ34Jd7o1HFoQBCaJMEAvaXIHU84ZPrsb2DwarSpPK3I+UCz8bwx/FN86zysShmrdFA3Dvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050288; c=relaxed/simple;
	bh=7aZKJbyybiA6GRKTswtBPQVXNPD6r86d4HvmzSEnrPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuOqqQSSZQPOeVcN3vKIjUor7xLcUNeRIT6pJkNeJqu0L9KW2Lwd5XGABN9LMDJXISTbDU3FVIeQhv9t890UP6UAcnw2YqBEnP4cPGbQXwqs0vT3FhStvK+/+6Z4s4/ICMeI1pfaLPc7wZoxSQPpju+ue3AyhRIkzBFmcLAZ85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jAy7spK8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so5535a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760050285; x=1760655085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRquNDSkjReozwM8w5z9laIwoCO0GSB+Y0DqaHKkPdY=;
        b=jAy7spK8fWh4ZQkArg/QJCsghOetPY4Kv17098hHEgcyLsK/hTnYlaE0ULWqAO6Onu
         8le0SA6beDpyVSu4agjRQlij9lUJeAAdioFiA86VvU3F2mLRlqx805cXpHVvnq7aMXeC
         F6tWW7RRzSO/F+7eHIR77R20LrDvcdoCONkWVxJb0WcX1jOXsulaqs3hSzxQBY+waLRs
         2tqNzKOkUULgSOygxrQ4sVrXUozJaZ7pkzNTcrJ7jOEqx82A+g9GO+P/36UIGkadxX0Z
         8V2k6KfiqvNlC041j256H9O7wYcsbqyi1FlD1E3cM2rXKx5cwJvBql76IBuE3pQ4flfq
         SAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050285; x=1760655085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRquNDSkjReozwM8w5z9laIwoCO0GSB+Y0DqaHKkPdY=;
        b=vrHxLHLFNRVPmvBFzGoBIlXcjBP4ilbnCPMHKEwy/KEJYhWfyl6Bx+W7nnw3guXFG3
         2oTZ7ziKVAzII8LKvSc77soAerhNkxy+9lWPBjsZlR9CehgkvFPrj76BbEdWtsYCfVLb
         U6PSdwugQboJNLT3cD0v9xqvW7A7wJ/6SXtR139Yjvveb8J8QOxRrp4TNHCHwZFcoVEa
         YsLAy+/FGTo18Qeevx636YUsHnAyA0JU/UNa3DC5QNo9EvAYtUpxrau22XCEPaBbcSW7
         Hvf9zJJA+Db7FkZzv36ldC2FUsCqlTNxa/DWwAuiuK3InUA0YfRCpmXAQ5cfKREBGyd6
         vz/w==
X-Forwarded-Encrypted: i=1; AJvYcCUspqKFsbnFsYUvOrJ3FVuOeFD3DTzNcAIbw/JuilDLUjqQJQ5t2ox6BDuqS3xmv5hzb6etmyGXH+WeK1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4rH24VLtJ6LJmYN1J4WclErKzugSIAX0U1Na61993hnKUlB8R
	ja904onhrK2v+8L642HAj5T10KGjGGInfj+OwoJ8dAbx2BLgLTi5I3f0frw4QZmEIEYBOzQ/aqv
	jhco5D9f9/S8K7rbhuZ1/BEipH29JNhkjva6Aq7ep
X-Gm-Gg: ASbGncts2EvORQzZcB0Fg4sAm++SuprYT/3dQbs08GMvlhw0XocnMu9RgdvVe4lcw2f
	3w/SjnK7ZfXoBMdCPeHQjyuhhCdxhYHBD79UhcYCzXrX5PhyAqj4mmbBtN/VrU6RHO3sUrTcISA
	TPDsm0c3M3UR1WT6kadByGo1L7W/RTKp313LjSFx5R30TIAAR5zDQSwydbilMlmkcODRTU1nBxX
	I7pEO/N89CbLkUDP8WgggWobFnalMiIt2fjKfE5h7T/mKco
X-Google-Smtp-Source: AGHT+IEHFLnEHNywvEzNEtdVs3WgWikpHRuWCajMSODPTnzUEkgN4GSZMuBA01mgfqW2pcRrsssSZOK47nb0K27gWYc=
X-Received: by 2002:aa7:c397:0:b0:634:38d4:410a with SMTP id
 4fb4d7f45d1cf-639d51d0407mr299985a12.2.1760050284823; Thu, 09 Oct 2025
 15:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev> <20251001145816.1414855-5-yosry.ahmed@linux.dev>
In-Reply-To: <20251001145816.1414855-5-yosry.ahmed@linux.dev>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 9 Oct 2025 15:51:13 -0700
X-Gm-Features: AS18NWDEHkKkDPLd9VdqQ9FPOQ1ms29elU0IRxQLarOI1HmjuFRwGgjzCWZ8Dlc
Message-ID: <CALMp9eRv3nraPfKLExX=cxhqSrShg=74gMkYh9R0jerhG4tt-A@mail.gmail.com>
Subject: Re: [PATCH 04/12] KVM: selftests: Extend vmx_nested_tsc_scaling_test
 to cover SVM
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
> Add SVM L1 code to run the nested guest, and allow the test to run with
> SVM as well as VMX.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
> ...
> +       /* enable TSC scaling for L2 */
> +       wrmsr(MSR_AMD64_TSC_RATIO, (L2_SCALE_FACTOR << 32) | 1);

Why set bit 0 here?

