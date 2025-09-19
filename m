Return-Path: <linux-kernel+bounces-823837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278F1B878BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D2B62442C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35541F5617;
	Fri, 19 Sep 2025 00:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="av0HmmwS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277E34BA2A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758243526; cv=none; b=eyz9SR9uQKRh8I7G8/oBWGwCR9BapIZBYPkgC7vt7LpvSGNcqR1oe0zyJLNvjWMI/qPH/dGajPn4H3GSqyMJQfam+cjAB3sXWYKKNfgnTREMwiSV71JU5pu0EehlDsgbU+uaow0wjeYwBI2kcO9a/RzXw+9vTb6gGS6lelt1aFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758243526; c=relaxed/simple;
	bh=INL+jGniSEK6jlOzw1pZ4EBFHb9iVRN2n/+Wi3ZEWR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKbsabF8PQ8baNdoyZlArZFRPuHgcwSPCUt+cwcTk7ETzBlrZuIxI4bSPCPOjmHbCxPFChTuXIvINc+bNowFq71WT1C79joXvi2BSsd/lu0EbMKuPI97EccDhkIOe3ZXL0SUbKCvPGgH5zVMVvQUta7srqqBeEpFAgu7h/P4Mig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=av0HmmwS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758243523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INL+jGniSEK6jlOzw1pZ4EBFHb9iVRN2n/+Wi3ZEWR0=;
	b=av0HmmwS4lLfHamOm4hfIwQNRMQV+75yAQmYzyUvZuIp6IsKw4ju+hQ+dQHFzKKX0RufKd
	9V87AS5mrdfJrWtFZEOdCJjyWct+amNfMVzuzGmLbU0RIgh3OC2UO5a9Hi3Bd0OGYldDfk
	Tv2nbg17h6bjxtZN7k0XYGyUU37pnyw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-cXKLb5lRPtiHmgvZy4rEDQ-1; Thu, 18 Sep 2025 20:58:41 -0400
X-MC-Unique: cXKLb5lRPtiHmgvZy4rEDQ-1
X-Mimecast-MFC-AGG-ID: cXKLb5lRPtiHmgvZy4rEDQ_1758243521
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78e50889f83so36421386d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758243521; x=1758848321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INL+jGniSEK6jlOzw1pZ4EBFHb9iVRN2n/+Wi3ZEWR0=;
        b=CZDpKUgwnb1qvpBDa/ALAdYJz5cPQdKfp1+bnlPbFMuMByQAcFJyT/X2iALu6RNi6G
         FCa3MrACSqlGTdn6tsRDcampD4r3EmPvHyK1yLGCdLnJaWEqazRJLyOSOy0n7GbRSd+k
         bfKjINf4kQ52eY5pa0gN5kthPl/5RlLolnYKmsnSE8mr92LIBeuqF4Hm31bgOUfpz0ZL
         fxt3bdgkrxinOQKsoYdiXm6HyfX/ytosCNTN5oj1u27i2ASAVAJa8bg0YtURJ6aB87yX
         umszwVfw5EnZZTdeGWfiAI/9YDaa5SQmsntvuasG9dc5l7zPyX3PFjf1CmXzhSfX8s1r
         XoiA==
X-Forwarded-Encrypted: i=1; AJvYcCU3kZfya0GDB+gGkDzHJlfLiWsf/8lEtnDuiehGIVM5HDMrtrZDubs6aoaTQN//kLLZrymoe7CfPyK55ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtnn2FUDcXaYnleIrkpbb8xKw/A5UjBuSRg5pftps3/eKl+Wgg
	OHGzwCGKvNkbpYjjfK5aXmoKpAh+m1aCIUIzdPoVhOlfbv4i2FrTJHj+8HwSef+G8GEmsE9y2aN
	D5OEW5k8+NyVwpH+n2WqePLGlZMIId4fkBv+SMN9E12mlOZkE4s58NXWc2f0IAiqHDPUdORPmps
	/HzAZWuhWsHkpx1va78llabdh1JLhSkjJvN20shMCu
X-Gm-Gg: ASbGnct/lFcaXqQWfp+oqcRGgs/we5907YtR+dsWr53kPnF15rf06/IieSSb975WT9R
	XITvmrdTLGlut5yrBYYGtFgqKE1xeEyJL+IhGnHFuIOh8xqLfdMKPptTN45dnigGHn9ttuVvFpH
	vn7N95oD7jWpVDMP3BYgdDGQ==
X-Received: by 2002:a05:6214:234e:b0:786:dc95:7b4a with SMTP id 6a1803df08f44-7991f60498fmr17130046d6.54.1758243520860;
        Thu, 18 Sep 2025 17:58:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCePSrkJyt8xOhV9XFxKyR5ORnkdYCLN1UQ0pORMOf3Vpbal9XfU/aSeiMZSMO/Y8ggPzzI0yEwXtZdhKDphA=
X-Received: by 2002:a05:6214:234e:b0:786:dc95:7b4a with SMTP id
 6a1803df08f44-7991f60498fmr17129876d6.54.1758243520392; Thu, 18 Sep 2025
 17:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com> <20250918-ublk_features-v2-3-77d2a3064c15@purestorage.com>
In-Reply-To: <20250918-ublk_features-v2-3-77d2a3064c15@purestorage.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 19 Sep 2025 08:58:28 +0800
X-Gm-Features: AS18NWBMx6gMYpA8xwEV8T0_f_E3cL4Rmg1pd231x9f1zxxG5V9QV0oQsLm1gZ4
Message-ID: <CAFj5m9+ZFkuq=n9R=d5N_ePzrtvx44TdR+YniCJVEWu_P+DGKw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftests: ublk: add test to verify that feat_map
 is complete
To: Uday Shankar <ushankar@purestorage.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Shuah Khan <shuah@kernel.org>, 
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 3:34=E2=80=AFAM Uday Shankar <ushankar@purestorage.=
com> wrote:
>
> Add a test that verifies that the currently running kernel does not
> report support for any features that are unrecognized by kublk. This
> should catch cases where features are added without updating kublk's
> feat_map accordingly, which has happened multiple times in the past (see
> [1], [2]).
>
> Note that this new test may fail if the test suite is older than the
> kernel, and the newer kernel contains a newly introduced feature. I
> believe this is not a use case we currently care about - we only care
> about newer test suites passing on older kernels.
>
> [1] https://lore.kernel.org/linux-block/20250606214011.2576398-1-csander@=
purestorage.com/t/#u
> [2] https://lore.kernel.org/linux-block/2a370ab1-d85b-409d-b762-f9f3f6bdf=
705@nvidia.com/t/#m1c520a058448d594fd877f07804e69b28908533f
>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,


