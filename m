Return-Path: <linux-kernel+bounces-782552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FE2B321F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3741D28535
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15632BD016;
	Fri, 22 Aug 2025 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2IsVA4u"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D129BD85
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885763; cv=none; b=NXuGB/Dp3Dx9hPoBrUKdK0q3C6CI5N4WF35Pd6S1yJoU0ju9K/7WRoWB9lREdvns6LtSVazFej8PP89i44r/doxwN+xWWSVveY8JJmtOAllOFIPBqQFZ+q2REcerO94dOSIKWDUwRD9QcJPW6sz8fMi3G3HIf6UwB9t+jcdNvoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885763; c=relaxed/simple;
	bh=Tb1rxvji81DhNvos9+34Dpiz+Ba65Rcpm8zkhIppG0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wy/Zxfv+P1koSX6PpP6JEKYUG+sN4U/uyxDru1+7f85yJWVodj9h3B4gP1uM2SAyEtQrxe+5OK9R15a2E+JAkcSeDMZSJfhPevSnIrx7dixj96/SUqNszSouiiSTUsiVeN+SYQTTrTRZZjVP3HbeM6dAaOSttPSYZKJ7O+2zgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2IsVA4u; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24611734e18so14415ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755885759; x=1756490559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWb7ujFJINgkd2DMZmp5XVtgDqGOY0d1N6wa3FF1s2Y=;
        b=q2IsVA4uk7cAFQyRT8/zD5kkaWNv1H7tnRqdHK6frrKyZpDmpAX3ASRhPpVgPnp+F7
         UxXg8ZWXnVnn93ZNqpRPrJfXC+q1dGh/Ekh/1QGBzsn5pQLAfkEpIzCKvVdAl8VNb5Ek
         +A8Bihb4cixZdjz4p7sbaOoBjn1USipl8C9PUqlcrtmhplKf14KijV5ELIBSXXl6kqv6
         CcV3QgD6m0eiA69MGn8nDfZiNTGbI2dj32Wm7RrjWPTis3E8qX6H5bvOvUaots9dPHQt
         ISzlYhrK4njCGjFMeG756/SfhcUukKI3g9VMOi//0uyWEpGa70lC405sMlwFIMb40geP
         hw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885759; x=1756490559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWb7ujFJINgkd2DMZmp5XVtgDqGOY0d1N6wa3FF1s2Y=;
        b=frK43HnUJA+DJghIzTjH3rCEFPUi/UfGrdhiMSdd8V+2VHmUd2xEqpzqHlZJihbMqr
         2CmPWrCYzrs8uFVVNyvhNxk6goRe5VcaML6wfS3/K9t3Tm6DvAl3Yl2qjeK1wl9w7zcM
         sLHcR+u4GrRcS40GdrtjoSH57GfjeY5L69mckYUSLUPZzIvk9jXz1OkyjvOmMluIS2dy
         LBH2N9dsBU5vAdbtWdYKfTtipgxw8Sxw+OGnonZoJiyGDilw3njGKYBcH1/KYO5938rs
         C+ES/tBVT9EsOmV8pMmy68TasIH5laEkol1k8rKCKyGl2ucbvpdez3/dshUTSAEj0o5H
         v1Gw==
X-Gm-Message-State: AOJu0YxVAaRGExPDTv6z+SrtwZVPThim4WjoyYw+RidW7kecpDvnifJN
	Bg9zSQj5W1tkEj1PGCw7Erf3bVPd5ED8qVRP6YmeF1i1Adq1Y1V5JiQfttJ3kwrCmoqSl2tUh/x
	fvnseTy8Nblil4G4wfBh3ahUjN39CKth6DQ+/akmdgJSXXYr6jv0yajxd
X-Gm-Gg: ASbGncvm42KaESmmrQJA4oGZMT1jcbbRy8Uu5PDhf0SCXI40MJ8S0uxjPS4SGSCpo7T
	V+R7PeH44IkozoeptZ7/tdTFsBhOeGUZbl002UE0lYuUgimb64gkGdi72FtUspVUKKa6EGN8uTj
	EyP1Jx/fkPtJ79+CaCA0eBAht4mdqCdrMYQZ1ghHpw5mumwMI5imsxTpXz8I8CyxB/tPu0ObX2o
	kyS01iTy2qU95o=
X-Google-Smtp-Source: AGHT+IFA2af6rcs83KxLB8fpKojCpWMKu9Z76RWMk+J7SWpv7uZ/ZhBHV2AkeRZ3bikP+3HIPQPdbu4m0lj7cvNT4m0=
X-Received: by 2002:a17:903:2f82:b0:240:520b:3cbc with SMTP id
 d9443c01a7336-2466fa251e2mr168825ad.14.1755885759046; Fri, 22 Aug 2025
 11:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822122540.4104658-1-tmricht@linux.ibm.com>
In-Reply-To: <20250822122540.4104658-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 22 Aug 2025 11:02:27 -0700
X-Gm-Features: Ac12FXyykAui8r7AO-hPS1XawpXPdLCTa7zC7cWNH1M5PInPONEDUvbV_1htBbE
Message-ID: <CAP-5=fW43ZAguuB-FB2F6CFTCgd1Fy1Xd+WAt4WSA-fMRTwG5A@mail.gmail.com>
Subject: Re: [Ping][PATCH] perf test: Checking BPF metadata collection fails
 on version string
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	blakejones@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:26=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> commit edf2cadf01e8f ("perf test: add test for BPF metadata collection")
>
> fails consistently on the version string check. The perf version
> string on some of the constant integration test machines contains
> characters with special meaning in grep's extended regular expression
> matching algorithm. The output of perf version is:
>
>  # perf version
>  perf version 6.17.0-20250814.rc1.git20.24ea63ea3877.63.fc42.s390x+git
>  #
>
> and the '+' character has special meaning in egrep command.
> Also the use of egrep is deprecated.
>
> Change the perf version string check to fixed character matching
> and get rid of egrep's warning being deprecated. Use grep -F instead.
>
> Output before:
>  # perf test -F 102
>  Checking BPF metadata collection
>  egrep: warning: egrep is obsolescent; using grep -E
>  Basic BPF metadata test [Failed invalid output]
>  102: BPF metadata collection test             : FAILED!
>  #
>
> Output after:
>  # perf test -F 102
>  Checking BPF metadata collection
>  Basic BPF metadata test [Success]
>  102: BPF metadata collection test             : Ok
>  #
>
> Fixes: edf2cadf01e8f ("perf test: add test for BPF metadata collection")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Blake Jones <blakejones@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/test_bpf_metadata.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tes=
ts/shell/test_bpf_metadata.sh
> index 69e3c2055134..be67d56e0f09 100755
> --- a/tools/perf/tests/shell/test_bpf_metadata.sh
> +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> @@ -61,7 +61,7 @@ test_bpf_metadata() {
>                 /perf_version/ {
>                         if (entry) print $NF;
>                 }
> -       ' | egrep "$VERS" > /dev/null
> +       ' | grep -qF "$VERS"
>         then
>                 echo "Basic BPF metadata test [Failed invalid output]"
>                 err=3D1
> --
> 2.50.1
>
>

