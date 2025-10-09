Return-Path: <linux-kernel+bounces-847562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2571CBCB316
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031CE427D5B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2F7288504;
	Thu,  9 Oct 2025 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAh4yP9t"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C52877DB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760052480; cv=none; b=ipDoqKMTMVk70wVRBofCy7LjZGrv6Ayf4i/09Ay0px/hUBcvKbtc0I1S+/So3yAEHx52q+uqyDom64Y2LPLE7/PeGGVXReQNn3CiZJD7S2/bIaXHJ+eEm3uW/HxphGUJJmI0bJ7j/HvqjLANHXxExMRNRlkdLJJ5jfr8GObHkA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760052480; c=relaxed/simple;
	bh=9b3Zxgci+mKgnZhX5L7HtPaZQdIRtQaeOd4XtqfN0Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aw5WRYB9FvdQs9ytXssXuqemcMxvSho3sF5zKEbgNfbmzBwTaznsi4BECVtVo43IAoC3ThAdThG4/Th8L4zBXAyWBuEMC5wFmwxoeDpb/w1s5uMhvUm5xcHaeIRzUVgxJh4Olbj8R+FS9IjVo5PD15EcTf++ZEbwxJ+wL3oV1K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAh4yP9t; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so2658a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760052477; x=1760657277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9b3Zxgci+mKgnZhX5L7HtPaZQdIRtQaeOd4XtqfN0Z4=;
        b=eAh4yP9t4/RJ/UrQt2P7ZDDhCBexG1Ya5AdEcUO7Y90w7ykSz5+Go5PlwYrfCvWOx0
         GBDa2Xiudr4gNFae0gY+qQU6PE5Ln9CkgkioA+Hr++QhGNJen9/jEAGxKZ3c4h7vK/kr
         eL/otxcESlK87LERTw9xsRaxk0CGu10+vHYm/fqkcteg1C6x5tVGZPjPoa+wu3u/4x27
         d1J+b4SW+7kF5RJiw7WdJrd4YaIopv7NKpQVPAMaJV0uKVput+7h8UNFSl63OOHIBJS1
         Ww/70bPKm04spa+LLAesMWlVH1BIDDdlpmgDxQfLA92/RURSurEob/cltxhZX4llgg/I
         ESEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760052477; x=1760657277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9b3Zxgci+mKgnZhX5L7HtPaZQdIRtQaeOd4XtqfN0Z4=;
        b=D2/rUoOSWXmBKStqQcDlN7Ip2kpuFrLuVOgiNbeRt7Nqp+hTRGIMuLftQ78lfW2cTS
         4hQbH3Aui6z3ERRFLvybFUzIVzdeZzivTT4xzFr/7hlcuYQ92AHCJcPCLu3QmHpfL0CS
         5f3Ct9JyfI4/qyRGMDlKY62ouizmlgWtUwe8dNOxhcghif7+2oiKJKDw2Qclx+DLD08A
         9vAOH5bD6YIggCqO4EdmD4ahdyzu5vyXBA0bHC4cVvwykU/jq+ZTNo1Uthf2ICBaRSx1
         tSIwXPTRhRZYknbq34+MTitwoKSbnEFYIXu2XshUclNbu+NKdz0SE0r6S3nXzo3ziZnV
         Ma2A==
X-Forwarded-Encrypted: i=1; AJvYcCWxBHJNJzBLAyLGSL4A3ezhdJiT+YdXoCGMlhcEpX6BTcyQaVHiQaS43W0jXQn7aijilM81BUfigTnMZ0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg6wp540kW/Y/pD+17ZeSVkVJcQQ85tJB6e8YZzqFiXJYj7k2p
	efbhvbQAGE0Mewhh3MBiXO1pq1NXS17HdnDuufVV01bpK6Wz6+TLdNgMGdEzNBC9Q/pjZWhtJnE
	xsitkAIot/FKb68UNC1R7HgdafI71WA/7RyEon1/V
X-Gm-Gg: ASbGncshFwgKnn3rb9zBPeRDTw/5WTyzy6PGj5J5PNsxfkfCLiGVLeqAQsjfBWSIgvW
	5i23Za0zTKMjiJu+IF9YPUoESUec4ScGwXb5GZGltSmB1sUfjgGuTuUcPJMWyTMBAuR7ZLfIuL2
	S2JTrGB2mONI8obnq1d6IEjiI6CQSb8jzNfg2F+Kz9SZfOqRWsMfSnThmU30H9HTg6FOoQOkBDv
	LR99eSRZA4G4eqz4xcmqJV1JZB/YG055suq07oxlSASofwL
X-Google-Smtp-Source: AGHT+IE5cTj29EQ60g5NA2LJo0NoCUMIsiGU6bW6OQpL9ve7upGwilWl79yHRPGcTpoLlvEyIYYTrw2ejMtgx/moUkg=
X-Received: by 2002:aa7:d889:0:b0:634:90ba:2361 with SMTP id
 4fb4d7f45d1cf-639d52e9f0emr335679a12.7.1760052476715; Thu, 09 Oct 2025
 16:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev> <20251001145816.1414855-7-yosry.ahmed@linux.dev>
In-Reply-To: <20251001145816.1414855-7-yosry.ahmed@linux.dev>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 9 Oct 2025 16:27:44 -0700
X-Gm-Features: AS18NWBk2cvpYkPkIOoV7BoxanaE72QhB_6V3q9DjGzblbZNPy2O9Oa2OARHAN8
Message-ID: <CALMp9eRMm-OX83djdRU+XdT=Bb6pHf5zZAet_fXYpAGO_Uih7A@mail.gmail.com>
Subject: Re: [PATCH 06/12] KVM: selftests: Extend vmx_tsc_adjust_test to cover SVM
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:04=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev> =
wrote:
>
> From: Yosry Ahmed <yosryahmed@google.com>
>
> Add SVM L1 code to run the nested guest, and allow the test to run with
> SVM as well as VMX.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Reviewed-by: Jim Mattson <jmattson@google.com>

