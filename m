Return-Path: <linux-kernel+bounces-846933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4C3BC9767
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A52A420AEC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B5E2E92B2;
	Thu,  9 Oct 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWAdSFio"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE0260590
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019430; cv=none; b=PIocQxunm0rwsxr9dlb9gomNG7Y0DflJyYf9w+UbVYvQadBApjsTVHYwb0EMjs2UQ/xZRcetcYxKZE6j+KveOY6Pfp5rRu/eo6wivD625oZ4AvyT6w4cdL/xMwPwQN/LH73w9M+u8wVUR+PulAPqIpnqSWUHD53wjEXa0C8kEl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019430; c=relaxed/simple;
	bh=/CLrhferOI53uFTYqvRaXBO4XQv9zvmyUYHZTPmj2Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrEy8RX4f/S/Hqe412bJVvdD7DzzcKt07XnTtWMM4XbKmRiBAoFz0dDR8TRtAwOUVuXGgdqsRrnrwwBx9hqyJzfgsnX3rdvOo2pg/O7I4vZ+9Yr15M7y463baIL2WvMXTvdJG7LWex1pLaHuxPvQlgvG4ml+83WY40clDRG5E3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XWAdSFio; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781251eec51so868542b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760019428; x=1760624228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CAGgXUa7jrEcPUZf+rZoYoMIoxF9gmUgGUWe7xlA3HM=;
        b=XWAdSFio9YBJKOXVpCMiG8E/QKejKmUA8deaBpCvmxUIIP0LgoT76K9SZpTpM1Dbnc
         wdP3eveDXl2yYkdD/NFq6mVEhBp1BKhGSmIKicS9ij2eTLVmvg7SDwo+PJSsrQpAz8yT
         yidlqLK2Jq2l0yH1yMhMYpavUlaxOHn1TAFS9F8RMJEBAIFm7Zx5JpfYnE4VzGQZCJUh
         ImpUz26o9BlY+7w1vc9fze9/Px8EgxiM9kpoPFZW5uqTNMduQxHYAe4eNs8x1lQoeE2H
         PPLsnZzHXhz58nDhrjUNTmUfSTfEciLP1NtwC97UF4/4ETKIZT2m4WdaSY0eWO1fP/v1
         1cJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760019428; x=1760624228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAGgXUa7jrEcPUZf+rZoYoMIoxF9gmUgGUWe7xlA3HM=;
        b=lS5epuigTA0RThIjV37J7fJleM0NGenFoiWMXK36rtRjz6EGH+vC3l3T8XFB1esJ9d
         cC/NVdM35AyfnA6JFRKcuofYsteyLc3eRt9R6fT715sga51btkZqUAehUX4Lb3Gz6adS
         9XBFcLd5oqX/j78U10S8bEAabA5DAAIu+/v/c2i9L1VDC7xrCi+soE8Qw/2TCy37wY3n
         MHIL3L3lNtoQ1csIayxGzIJQUfcfyovzKmH7EUDmYXyNkLCQTO8ZpAOs3GARGIfeX2Km
         K9hxPX9jwtDr0KVAjsnuvBj8xgSk5Cix2EXDKd/TPXklhfACBAbynlva6953vdwHrrpp
         kAZw==
X-Forwarded-Encrypted: i=1; AJvYcCWBLX25lnnVPnnq0bPMYGngSbsNLMnlQ4vd2WkXuEEb9iySl9vI9J7fkPbtVFCrZOowouBKawWM7oH12yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywue9SlKUZjM6pL4vWhU9pix9w2BNuCBSt5IDMriPwDe2eS61r8
	UVeWjZB96UA8TcUU5Mc8TYIRt43HB+5eyz+t9LGpKDiy89AOZ99naK5DIniX+U9UD88eLc1KXJR
	qkU/e7m4C0lZHpPGfrbfGfjcQzb/3dLPaCivHMrZoDg==
X-Gm-Gg: ASbGncuBsaUrkcXaBEpfB5F3/haK7D69UiOONFSf7ktdb4z4XBcR2iQqa7MNt0Rf1JC
	u3BwqC9m0XRUjjJMfcMe8jZJbp/71Ndgrver3a9bwOjfEIqBc3dVOghqzG9ZaJf44BF75gnJA9b
	7dhtfiuq345Oz0yYTuXP7ALN7V1WT8F1i2iy9QTo9s3qN4d8KwLkXcGiy0aD7O9p6HsHHPcxMIq
	3YzhU6ECfV9w3TiYWYTIhau/XsyLGoR6SEw
X-Google-Smtp-Source: AGHT+IHNiqZkNg6XPeFelUbllPF8ssAC0Q7z3PQ/udjq0kDEms+Yi6CfYpXwtOZXZ025zfvzYmbK8YD8WJrjzye5Z0M=
X-Received: by 2002:a05:6a20:241:b0:32d:a904:8bfe with SMTP id
 adf61e73a8af0-32da9048c2bmr7568674637.52.1760019428498; Thu, 09 Oct 2025
 07:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922095057.3136-1-liujing@cmss.chinamobile.com>
In-Reply-To: <20250922095057.3136-1-liujing@cmss.chinamobile.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 9 Oct 2025 15:16:56 +0100
X-Gm-Features: AS18NWBMLxvQq3EALWAjqVKr0csFKifCNSSsQBqJuIAM_-6p8ePV2UoH-Pz_cmo
Message-ID: <CAJ9a7VgxMt7Z22rB4+ndHYe-T-hV77BPwoHU4HFipySM6sXd8A@mail.gmail.com>
Subject: Re: [PATCH] perf sample: Fix the wrong format specifier
To: liujing <liujing@cmss.chinamobile.com>
Cc: john.g.garry@oracle.com, will@kernel.org, james.clark@linaro.org, 
	leo.yan@linux.dev, suzuki.poulose@arm.com, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sept 2025 at 10:51, liujing <liujing@cmss.chinamobile.com> wrote:
>
> In the file tools/perf/util/cs-etm.c, queue_nr is of type unsigned
> int and should be printed with %u.
>
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> ---
>  tools/perf/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 30f4bb3e7fa3..d13575285b19 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -777,7 +777,7 @@ static void cs_etm__packet_dump(const char *pkt_string, void *data)
>         char queue_nr[64];
>
>         if (verbose)
> -               snprintf(queue_nr, sizeof(queue_nr), "Qnr:%d; ", etmq->queue_nr);
> +               snprintf(queue_nr, sizeof(queue_nr), "Qnr:%u; ", etmq->queue_nr);
>         else
>                 queue_nr[0] = '\0';
>
> --
> 2.27.0
>
>
>
>
Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

