Return-Path: <linux-kernel+bounces-819040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E549B59A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B15D3AE51A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD8032ED38;
	Tue, 16 Sep 2025 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVd0sgbY"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A112F7478
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033420; cv=none; b=bfPI2B/Xjw85nxO9d3Jy16PsBp3uKbndFGuEhRe6wKJrZ9C41q6qvkuEQ6PGjIeZ2qGkhtm2F4E1F1whNHCg7nNMMHNyKn3AaDbG/W5j61zwI3y3DYRYQ+4CcTzVnKEDPVdKY6YjlFrN9klb/9l9azag5xgazFQe1YeqOQ4BKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033420; c=relaxed/simple;
	bh=s4BZfu6yLRiX3AYkgSWl0OqE0hIE2gm8knmVHEguHGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbCQ9qC+8sBwjQ0zDQO4clcZCXRAsZOVQUKnaYAaalC4Tc83Eiz2c1EhQIK3V6mystG8Zp1P/ZVbpv6dGjyXmFGj7tWAGS8rU0B+oijzoDCiNwqM0+AH2e+If+JXNb3Perdm8pozvw9+GMoQ1qRs0QRsYGTAPHoV3cyet8OdTM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVd0sgbY; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso5513086e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758033415; x=1758638215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s4BZfu6yLRiX3AYkgSWl0OqE0hIE2gm8knmVHEguHGg=;
        b=mVd0sgbYtPjacnZQQ4WgJAVG3qFhyQXgoiZoOUh82ko+CYtkEbHX9qLzHsKm34xb4o
         TLHr/4TrHyh2yeKqcZqPhj2j+sQBJ+EDn8O8/WigbIkR8I3UXSd8k0yLR1E/3zwz5L1/
         fbYeVJZcNZ+aATkzc6XHHy55PfkEj2f4WZQgoH5pN3ntIkT5GxLVVuWOvh+thyI0l8bV
         fEH6sdBu4M/HLFr07/Li/3O3MJ9Bfl6hg4pXUsRC7hNSA4CAjUiKdM89R6a5j8DJGUNw
         pC5BaRScrCT3OYZ0Fg47XdLbr6U1KiasRWKTk4p3dx5J8o3yIQvVTp2TkBkQAfIx/oom
         Jq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758033415; x=1758638215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4BZfu6yLRiX3AYkgSWl0OqE0hIE2gm8knmVHEguHGg=;
        b=Qx/uGt4koeNSK89yAWqyWktRM18pSKBfpg8BoizRpnBFMzZ8F8jJ6amNCdjDd8AChB
         sBA7mgEFuOfrg+WigNz41NpGoDGQt1n9XglYfMwIz62tY2biwpBM7l9w/9GXx8cVt8Ey
         GLPBk6w5Q5nOE7hSp6juPuF0dGioMiDlzSMh4w6eCYKDZc8Qmgj2lLBjny1B01shQnnn
         a8ycjH/qA+Hyp05kPfQg3/rx3GKX8GnIuKbjECkqtgzjXyTVW7cO1lBkwxeimwftOrKa
         r1fUT4dw6s9AE8YyrM++fuizUeSQO963umBORgxqyXvs2a0retkbXkoNVABtei7DiaTK
         om+A==
X-Forwarded-Encrypted: i=1; AJvYcCULPvYO7CpziJFlQv7MWEfLPrEqeE2eznC31obD9U0xCOELqaIF4gNdSmgByGWbCn1hM1pbKMVHbSzbAJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiwZN/GOFX3FbT+1q5KMNUzK9MeD3HgZKHLihDKMJQZ3SeS86R
	oM14wfMETWxtFFoZuPzpEJEN1NMN2t2k6PRbRgswrZcgRg94kdToD/M/el8XEDbiIDjU2Y9Li0G
	L4PboaiqvJ72zOVcaz9BRlmGtYHM54JBxR2VVf3oR
X-Gm-Gg: ASbGncvXyFsNJf+6GJuDVuQgqvi64z9xNPfrYySuC0tI4GR5F9pvNnGX2Kb4ZUUjdGL
	y8ELXwDCowl2X+bCeM3Qw3HScPC0Axa3E8SF+vph6H1NGpSh2vkcBq6vqztRgxDjJHBPfNyrL/4
	jSlM6nUAQV201QzQfaEQu65FA5UxJrhxQozcMeSrnYUt70vbMV6Ii/lpiC7SOKG+zRCC9Hb+o3v
	nLOpZP3anxYfCPftV+8qja+NMNmTBF1tEt9V1iLBQ==
X-Google-Smtp-Source: AGHT+IGHaVarPK5xt1Np5K72LY6E/5GXRbs5qLTHuoQWd1viNTNxXfbQAu05Ta7V3ZSw/ahbVVUvd6K4Gn+lu/92W/Y=
X-Received: by 2002:a05:651c:25c1:10b0:336:853d:27fe with SMTP id
 38308e7fff4ca-35139e55aa6mr44793961fa.6.1758033415189; Tue, 16 Sep 2025
 07:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912100525.531102-1-haakon.bugge@oracle.com> <20250916141812.GP882933@ziepe.ca>
In-Reply-To: <20250916141812.GP882933@ziepe.ca>
From: Jacob Moroni <jmoroni@google.com>
Date: Tue, 16 Sep 2025 10:36:43 -0400
X-Gm-Features: AS18NWBPbofJ2OdtXbuVGan0Wupm2O1UZneWM-RcR2E0FqSX7yV-nL-jGzQHCzI
Message-ID: <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error message
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: =?UTF-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>, 
	Leon Romanovsky <leon@kernel.org>, Sean Hefty <shefty@nvidia.com>, 
	Vlad Dumitrescu <vdumitrescu@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, 
	Manjunath Patil <manjunath.b.patil@oracle.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Does this happen when there is a missing send completion?

Asking because I remember triggering this if a device encounters an
unrecoverable
error/VF reset while under heavy RDMA-CM activity (like a large scale
MPI wire-up).

I assumed it was because RDMA-CM was waiting for TX completions that
would never arrive.

Of course, the unrecoverable error/VF reset without generating flush
completions was the real
bug in my case.

- Jake

