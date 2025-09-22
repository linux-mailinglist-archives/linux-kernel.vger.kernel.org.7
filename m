Return-Path: <linux-kernel+bounces-827922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD46B936F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0ED7AB547
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DC530C10E;
	Mon, 22 Sep 2025 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="xInuqUXf"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F02F617C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578966; cv=none; b=Jy84TqBAO00rG/fv9vyITmY1Nv6RSg2im/GBSjDjlvtLZrmdBPBxe8HDVih7mY3ISaGnoJ4ZcQck5FhfbfB4bxYyYrasEqynSfN6YYux+Kkfrsk3ghscfe7oNvj+df8EjeAAN3fJklonhhngjCfZ13UTsh0FlWbak8Vsh0A7cC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578966; c=relaxed/simple;
	bh=IbFE1oms2PmcouUl/usEZlCEVpv+9x2ciXv88pSf95Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCOfjEbusSI09TalwZcCddm7F+nlOtavTTvqDMBWOAYHgvuJPS3NqWppjREv+MKZfR/fHiF6NiSBmmcA/5ixLM+JW6k/AUxr9fGUqMJd9VwR9xVK826XODcOk4oXc5FqKLuCZdMX77t/v2q4Sw+q94EmbcelWxRFmjKzvl2h1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=xInuqUXf; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78defc1a2afso61753116d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758578964; x=1759183764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYnuc6j9qhLWOo/rZQKKbBmIkoY02H/yL7nkkmtQpxU=;
        b=xInuqUXf3Pqp+x74N9wFfgvpzAhwa+5bALmt6ibQQ7XeuKxNbaCeumKda3DexrwpVg
         Kzcyr0kPY71WfAVfJAm+/nPnv1tVSyV+EYBuUi5NNcI4NuuhIsudQELz9OXTaiBbE6CO
         tn1mpbFEZMu05y4iedP9eRzselTi5ZUeJRyhSmPaxCZGyhe08/ym9om63nr0mdiRPQOy
         0O3ck2rZOApODsezNG2ThkttLMa9fv1z801Ov75m/FvJ6bSNaM7VFq2oxJdKBBfz7xw+
         9GKv9HT2nMQSj3n89ZxolFFcJwRFGp0ACh7TrjipAGeZGBxmTRxuQlNUNJWRRKWobfmN
         AIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758578964; x=1759183764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYnuc6j9qhLWOo/rZQKKbBmIkoY02H/yL7nkkmtQpxU=;
        b=O+W8kko3guII16kFS7ZAzZgtV/kT0NsbSqQ2yG0udvbmjDHXMbe3FhoyL6kCQmoYJQ
         iHAsvcXL+64k+umbBw+JLo5w8TKov/LEnHC6ETQE3KWpRVUnBQnP1dzGWPUAY0PD98Hq
         Zta1OnYz2/XamAwpv+gcPyo8UPHJbdH2Ym32ChToLZEdPcxPrDwqYUUzAVIWb1DBeZ+r
         FTAZVeWcZobvQmcPUlmT4dsiz7CFmVUjgQJaDxw+qF7pQUv0IFhM0ClmkNxKW4a7DXYH
         UXqZcRS/cVGBmqTdfxVrhvrC0GBCtnyQsNVozG0dJwpH8DTjGoBMY73MZF9aCrE0yBr2
         bpHA==
X-Forwarded-Encrypted: i=1; AJvYcCXRe6EBc/2IlQQ+rRfv4u38w/o3SRc4f3l25JTvph/oTDlVmOTkH8vu0XFRWuJp+ihCLQVdtggh47yDiY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe38W844EDSvn4eBvIVkm3dVCfkJCwhv/oGIami2v+nHtL9xNl
	AiDp+3INWSTk6hKxnvWFnAlFlFLRNPEqF4S9pJkAmW6aD3B8OLc6G34gsh4m7gJMNxO3OBEe6yq
	CJBRXeuQ=
X-Gm-Gg: ASbGncv8ydRS4GZ3rmhfS82vnsrdRZGxu5TYEOHBUE3PH69n24XNUMGKM0QuySOH2VL
	8vC26GNohPnDslEs3lDqMMANASo4pvZeCAhAl6p4q+0VLynB4bbRintPcpYXaHwy95uW7iur8zf
	2fDlFigDVZ/AGpx6tohQ6CMzOTcU7mqZdefZUdCdlF7a/y7ewEsJrkcbwCvtyfzlt+1lcJWOCeL
	eKjujEqjsGYp6KFroyI4IfJauZg81WCxPCnw4Y7gtjjxONQ9qIz8r1LvF6UYChgrynIJgPduJFb
	eUSHAPxoUPx1ZUlUimqLrWnMOnRGLUwMei8NECXrnJ8uasX2//Me3HjjetqEyFvoaXm6GhrE0Cl
	sfrcp42xZy6MiNrcaBox/H/ItxniA1R08Qb+Sly2yesrUXs+zhMaQnPRedPAu3Xep/kRIkfV/zf
	GKUdQkj1yETg==
X-Google-Smtp-Source: AGHT+IH/Wx6XCxh+/R42m/n4pGW4Li0DeICaefpsliWbAkhEalUfjSoqc1W0yev1gXFbG0yEVMaLoA==
X-Received: by 2002:a05:6214:1c8d:b0:790:551a:a689 with SMTP id 6a1803df08f44-7e70381f88amr5363076d6.26.1758578964227;
        Mon, 22 Sep 2025 15:09:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793446acfa6sm79182216d6.14.2025.09.22.15.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 15:09:24 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:09:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp
 <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
Subject: Re: [PATCH iproute2-next 3/3] iplink_can: factorise the calls to
 usage()
Message-ID: <20250922150920.78b95c44@hermes.local>
In-Reply-To: <20250921-iplink_can-checkpatch-fixes-v1-3-1ddab98560cd@kernel.org>
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
	<20250921-iplink_can-checkpatch-fixes-v1-3-1ddab98560cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 16:32:32 +0900
Vincent Mailhol <mailhol@kernel.org> wrote:

> usage() is called either if the user passes the "help" argument or passes
> an invalid argument.
> 
> Factorise those two cases together.
> 
> This silences below checkpatch.pl warning:
> 
>   WARNING: else is not generally useful after a break or return
>   #274: FILE: ip/iplink_can.c:274:
>   +			return -1;
>   +		} else {
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---

Not accepting most checkpatch stuff in iproute2.
Better to not have code churn

