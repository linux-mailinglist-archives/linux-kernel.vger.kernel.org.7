Return-Path: <linux-kernel+bounces-857498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D55FBE6F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDA1B35A7B1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28A7239E65;
	Fri, 17 Oct 2025 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vv2SXQAh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D30322C339
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686703; cv=none; b=BdQDSCNu54HkZzpevzkKG/a6by18MUpniXE7+HDUUGpugDJWOvtRqSGpU4AtscQMLtLQ4EXuy2qJVyt1yPtQTCYp3io6lKB1MDZjDw+DLkE+IkMQCDNc00y5Fpf7MTqSP5RNYpQf2sLeb0kGy6jHJou2bk7wvcJH/rExQeGE0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686703; c=relaxed/simple;
	bh=1xR3x2p3tXsNA4DvviIFatm78+RRJrSmhV0Vasqy5JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6aakH5aS35zZEOXWSSCzzy2lc6snQRRLjZ9vR3enCTg5bCSk5j+2CJjcgyK3E2gWW6HESmoU2ZyqlxY7fyUI6wfc5PPhLZia9D9QT5atoB81fqhl73vajQqYvR5ItS6vjfbpPLHcq5BbZwEslH7ZeVSSLWO8iNrNS+ClXbMGMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vv2SXQAh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760686699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwE3xOWvcSpkeyeMXo0ARX5UbAfzECMBwVn6tM+Q/Ds=;
	b=Vv2SXQAh8WzdqnakWbCRJ2mHMwkCFRtd6z1/w+DurUvfrESFROMcYkw1q6f6n1HpJYkdQo
	sm1qtFCVr99CYt35v9v7N8Mz8qAZhpDYpeQz8T0T5wCtI+3bBt0rSIoxtGkAwwHtWX4wrk
	/ICNHT0LfepYGfgeOmgPKJM+BtgyaLU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-7GbW2nOQPy2HSDujM8ermQ-1; Fri, 17 Oct 2025 03:38:17 -0400
X-MC-Unique: 7GbW2nOQPy2HSDujM8ermQ-1
X-Mimecast-MFC-AGG-ID: 7GbW2nOQPy2HSDujM8ermQ_1760686697
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b5fcada9d24so211187466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760686697; x=1761291497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwE3xOWvcSpkeyeMXo0ARX5UbAfzECMBwVn6tM+Q/Ds=;
        b=SZcz546MUlbZHz0WqRXW/EXjrIBhf+Igt0426fWymaUw8ZQWqOGRBzX2qOiDTsRjVZ
         Op0xA/w6hiWJlRAafpQxyrwnazUHOJ92BHGOjJ6eT+j7ebQX/NtIwBc07OrKSGf/+LMB
         SAwuRlsgNjJYPh3ou2nNBaGkLop5/dzjgb54sTxmQLizV0u2bDPsi2ZDLQIHx8BzbFoZ
         rBA/UjecOt/vZv1vUFRHhu3SSkmX28R2i5otsR4EthmbxyEkK315bDR/UqB4qAZgMVB1
         FmCnJFf7nBx1UBS/vmDgNJOEP3wK6NWGuldD5ztFl+Re/BSmmmpAf27ztLjneUHW4dQD
         UpCw==
X-Gm-Message-State: AOJu0Ywtbr4gXRQPJBisvGs1FiE66dFDKf4bLafqJ7pZKPe4A/PGFJrC
	o2CrZtQLWG3jOD5H4/bQDEkpIyN1mwm2vARUU+iCW3cbdEkzEy39yXq3oH7WMGRz8ff/mr0ZV7b
	2AfK4oxFHqPibPxJgAqmpmSfAgx6Ajt9AalutQAv3gpmZkl/wPOK0juc98OXH7rgEOxrMX3O+zH
	gzegl+aEVwc9mOQnR8p0vFN3uoeAno4XKTv0HJYaKR
X-Gm-Gg: ASbGnct4zS6INpQM2QdA16kKF+qNTJxq+3kPdDxAy8v+2IBNGG2JpQmf7c5j8aHf5le
	7OgZb0vJ9DyXX2PQuJFLdudeCdDcGgGrmINzqDhxzbao6JT1a7D+pAn78uFIiMuEZDZQckW3Qdq
	6JMTQFV/ORgCKDThvwal2KbAKut1DDiU72aroqbAzGDZqdi0xml3D8L17vDx5UJ94IhXTm2tSWB
	WENgyTqM6lO8Q==
X-Received: by 2002:a17:907:9691:b0:b64:6776:1ee2 with SMTP id a640c23a62f3a-b6473f42d78mr267631866b.52.1760686696655;
        Fri, 17 Oct 2025 00:38:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETvQK8H1/2i5HNhE2R8KrdEFfqmdiqiQ1Yyb8MzQowPWJTSEJRTSXf97XI37+HGFw6Cuuibf+3ZWnRVCFNtKw=
X-Received: by 2002:a17:907:9691:b0:b64:6776:1ee2 with SMTP id
 a640c23a62f3a-b6473f42d78mr267629266b.52.1760686696193; Fri, 17 Oct 2025
 00:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007095341.186923-1-tglozar@redhat.com>
In-Reply-To: <20251007095341.186923-1-tglozar@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 17 Oct 2025 09:38:04 +0200
X-Gm-Features: AS18NWBD9D8J6fwp3TFhCJma1f647xufvtF8gv38JqAH5X5RFzQIY04cHnhavb8
Message-ID: <CAP4=nvSmJOdoO8q125sdzvR7ix1oVsNobSRtWb7ADUADdzEPiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tools/rtla: Fix --on-threshold always triggering
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Wander Lairson Costa <wander@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

=C3=BAt 7. 10. 2025 v 11:53 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.co=
m> napsal:
>
> Commit 8d933d5c89e8 ("rtla/timerlat: Add continue action") moved the
> code performing on-threshold actions (enabled through --on-threshold
> option) to inside the RTLA main loop.
>
> The condition in the loop does not check whether the threshold was
> actually exceeded or if stop tracing was requested by the user through
> SIGINT or duration. This leads to a bug where on-threshold actions are
> always performed, even when the threshold was not hit.
>
> (BPF mode is not affected, since it uses a different condition in the
> while loop.)
>
> Add a condition that checks for !stop_tracing before executing the
> actions. Also, fix incorrect brackets in hist_main_loop to match the
> semantics of top_main_loop.
>
> Fixes: 8d933d5c89e8 ("rtla/timerlat: Add continue action")
> Fixes: 2f3172f9dd58 ("tools/rtla: Consolidate code between osnoise/timerl=
at and hist/top")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> Reviewed-by: Crystal Wood <crwood@redhat.com>
> ---
> v2:
> - add one more patch fixing a bug noticed by Crystal in context of
> the following one (doing v2 just to avoid conflicts, the first two
> patches were not changed)
>
>  tools/tracing/rtla/src/common.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>

It seems that this patchset containing fixes for recently merged RTLA
code consolidation [1] has no further comments. Could you take it?
(Unless you have any comments, of course.)

[1] https://lore.kernel.org/linux-trace-kernel/20250907022325.243930-1-crwo=
od@redhat.com/T/

Thanks,
Tomas


