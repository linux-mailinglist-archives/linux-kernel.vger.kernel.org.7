Return-Path: <linux-kernel+bounces-757132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61E4B1BE18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F92316C829
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9CC13957E;
	Wed,  6 Aug 2025 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="barlQ94n"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67002D27E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442024; cv=none; b=m01UkkZBjsrAL4KZZp7F/b18RPmQKfZxrozTixbX2xlU6Ix29jwZqRbKaYC6e+zYS1pdGD9NYY67z2YUjvji8qHA2LoPd7gE54nr2PpEx1NqMlZcf1UkkaVZ+y1vt+DBO5Cq+PEUlfh/8b1lk4dv9sxOSdT7+psTULtLn2oPfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442024; c=relaxed/simple;
	bh=p1mRerMEHgeNuo8Gmi2HzaVtdWrvQbrDxXm8DmzOiqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmHRTSUYLrzfv3IuH3CRMi1NcdUPyoL6RRzYx0QX00sVlbOr4qZTu3xDpkMPKvfTSSpmh64WEWXvAbAekrbU7PWQlR8cQ/K018108ue5b/JHuaCXKAp1+AXzYeNFy00FnqBBxMmSpi2yeL7NvMEtscR0oZXmEGoHD2KY6ow+Ojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=barlQ94n; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b0673b0a7cso282211cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754442022; x=1755046822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bX8EsWN8G5GL6UrgORFQI2HBOvhhV7DfKPKAupHsb3k=;
        b=barlQ94nlrlmRHjnzAYTLjyJxMyAxMMrwVtitk03aFbBIQ1d/bK8DkfrWcG8H2svXq
         iK1Ptu7AEoFbkoH6UCU5qj9RafRw7Ixgr7SS2Wb5tHdRio8fcv3Y5ju7kuF8xvTH/uDo
         cK265zWIDv5qL25opBciHCkjaTUi+VHOPI3BV808jAEA046Ur+UB362NAKSxRFLwt6p8
         SiYpIJrRYCbIYUnfNdyNapex752z/vinto8KJ/hqD2NkDJmOgAnl6D4pKXerLlMfXDJu
         NnEwW9zJDdRT3S/gFIjssCk98Uh8KyWDnOzL3fQkZ6z7xQ51Bf4fvwF+RQhjPC1alxsw
         Dtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754442022; x=1755046822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bX8EsWN8G5GL6UrgORFQI2HBOvhhV7DfKPKAupHsb3k=;
        b=VeX6wRWBx2eGRC2T1JiW4fgjXiXOD7jQd3OFGL+VdWED1FdxPOyoVmT+qCQLqx4o/f
         KhaUfBLmUloBvNs4OX4tlsbfNZceqtioksZ1BmAeWOHom7yIbbFECEv38wldznrmQ8uo
         iU8CK/9BGsW8LigC37FKJ15OYq7QfthuLpaZNO4dZqo/hWoGflQkSFqp9kdA7AQGJi5b
         VLlf3NxMZdJf5ixxKwu28BTWMz41Zebo37LMJ3TH84VXXcGMs8AwdmZdvbCUFTColvp0
         xBa4jCy0EUCK2DGu6GYd1maCruBDKcuR1o5MMNNiva1IPrfYqqXQPxd3Ki5xZ4W9Z52G
         u+5g==
X-Gm-Message-State: AOJu0Ywt4VwSSR43y6a6FjxavqwcPjjxl/lv97tGytOHnYB0XEZBLDyR
	v61q90kSGjTEqnOPH7sK6eBhbTVLQpj8HBncn579ZTNlC6ZyIO7HXgSxkwqQZpVSrjBh+8WLLnB
	f5HhCDFco0D06XkQJvgwECYmw9ASO1CCgH01uOdYz
X-Gm-Gg: ASbGncuuP4eeOsb3DvAJ6pPVQIxvFcOn9YaJcczWiURg+VMwPbvEoGJoMEhQ6c+31xa
	OaPv4mFUsoadtM0+sC3q34t8LDrkyDLYQe+ysxMhZV/+Y4M7rrUVrYmd6LDPvfmXBxo/35WDJN9
	AJnI7cnDtdCt/tXPSBrlFzj3JIiA3UgvgyL71RUAtrPp71CUbgoQJRtAF+SnS2ejxF2zGkcr0Gt
	jujcQ==
X-Google-Smtp-Source: AGHT+IEYZXFlvLRTmvPHs3BhJmh1UNSqPuk5tHmGvJQ6E4hzMgUc2DFs9BUi1j7G902TGr1aF4a8qL7YBJk9bs+bEQs=
X-Received: by 2002:a05:622a:10a:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-4b09261a067mr1532851cf.3.1754442022008; Tue, 05 Aug 2025
 18:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730220812.53098-1-pmalani@google.com> <8252b1e6-5d13-4f26-8aa3-30e841639e10@os.amperecomputing.com>
In-Reply-To: <8252b1e6-5d13-4f26-8aa3-30e841639e10@os.amperecomputing.com>
From: Prashant Malani <pmalani@google.com>
Date: Tue, 5 Aug 2025 18:00:09 -0700
X-Gm-Features: Ac12FXxCfIuM-Yd1FZB6zRpfVYWwqRzEGG2J-R3Y7u-oTDt1TL5FFE9U-zeRXnQ
Message-ID: <CAFivqmKZcipdc1P1b7jkNTBAV-WE4bSeW8z=eHHmtHBxuErZiQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Increase delay between perf counter reads
To: Yang Shi <yang@os.amperecomputing.com>
Cc: open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, beata.michalska@arm.com, 
	Catalin Marinas <catalin.marinas@arm.com>, Ionela Voinescu <Ionela.Voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

Thanks Yang,

On Tue, 5 Aug 2025 at 17:26, Yang Shi <yang@os.amperecomputing.com> wrote:
> Thank you for cc'ing me the patch. I posted the similar patch ago and
> had some discussion on the mailing list. Then someone else from ARM
> pursued a different way to solve it. But I didn't follow very closely.
> If I remember correctly, a new sysfs interface, called cpuinfo_avg_freq
> was added. It should be the preferred way to get cpu frequency. Please
> see
> https://github.com/torvalds/linux/commit/fbb4a4759b541d09ebb8e391d5fa7f9a5a0cad61.
>
> Added Beata Michalska in the loop too, who is the author of the patch.
> Please feel free to correct me, if I'm wrong.

Thanks for the additional context. Yeah, the issue is that :
- The new sysfs node is sampling period is too long (20ms) [1]
That makes it problematic for userspace use cases, so we need something
which takes less time.
- The central accuracy issue behind cpuinfo_cur_freq still needs to be handled.

[1] https://elixir.bootlin.com/linux/v6.16/source/arch/arm64/kernel/topology.c#L283


-- 
-Prashant

