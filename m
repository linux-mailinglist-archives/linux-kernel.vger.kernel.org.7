Return-Path: <linux-kernel+bounces-779045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA7B2EE50
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D68F568815
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E52E7F29;
	Thu, 21 Aug 2025 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPMKTlPM"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA033255248
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758267; cv=none; b=KPvHceOngE5qXpMqVeGcUE4YW1tkFj7rEfukpvhTXHCW/OtJuz7MWiEEZ/uIIQTTfkhpNoRqQd5XQKooHKeo20xMHIjgwZPkMI+vk38/19okhDCeedzL4R6PX81Gqt/S4pLs66zsoRzZBUUc63lMuHz3FVNgDAYG6FFEfJ3yPFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758267; c=relaxed/simple;
	bh=PhYPqA6hOPWR2DVP4gF6Ag53GcEYP5E9kKRpJSRcAGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lP0P1+mjmkvaCKAVXLaxSaXIrdk5o3uXuLE3UMC5VLu5WAoRXu3eWtVHtCnsy87kYOy8Tw05hP5QQTChzP+A+IxyJ5maiRp57isGyuxioDx4htt+OmdBZ7sMBkW4B1OUMmTjoNEguIhrWj3FWks6ruE7jvu2+I5k3h1VRS4nUMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPMKTlPM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2461864f7f8so4365ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755758265; x=1756363065; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhYPqA6hOPWR2DVP4gF6Ag53GcEYP5E9kKRpJSRcAGw=;
        b=WPMKTlPMcvVMCG2+eFRxtTmgscvQgQsU21CE3l+GURBbFyqbMJb6+DAOwSJimc0e3i
         6Nd6QZ8nmMOAdOM4Y5p6ReOxyE4IZyW9aIpqLtFQ0c4sM6d98kbCdTX7zvJ8k4n2IPtL
         rZcNQuyFJaLKFOstL5vTzm5XZT7RPwOdrHfHuTfBixztb634Rofykzz/lN0fIbz3R9JR
         wnEBb5JlGQVyOBaFtCrPhz+2jc6w3XN7xbVKo7NrLQK1x2/yFNqZ0R/W/wSjjpEfFF6x
         syixE37qXnxSn54cEDPMXGaplUFoFfct+xr3cTtY9yx5jtN/6aryjL4rjXFpi9i/d2//
         VfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755758265; x=1756363065;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhYPqA6hOPWR2DVP4gF6Ag53GcEYP5E9kKRpJSRcAGw=;
        b=pVZkCeyZSM994k8DpivthlK2CjnTrQYeIykqctut+x1pmXIANgVOSXEDqt0MjohRZR
         B26h7IOVi+UqrhSWDEt4DQPxIMTRPurH72h6+WLpKilB+iDCCm/rLdZjNKLtZtRkhpNR
         dCkdz11zKZzrFJAhYz1WRMLoCZ9utsAM3XzMHJ9y8+UaF6sjb46NsW6TwLIH0HdrNmbP
         qNMEWyS1D8QVhOoTZjyQ7mxWg1TrARRgElMnIRt98a0HEOAnDhSRjGgQFBdXSxbX9Exf
         lqpTNOMvyZbuHQU683xEf8aNc9DMvnEVn4pniMWavpbYtkHGko4F8RniVWnAq6Pbf58E
         PERw==
X-Forwarded-Encrypted: i=1; AJvYcCUWnWjfP1AyiOi5c+yaWS+a66fPm5/h78Kf3PfzHoeeTt2oO3eY2L4O79p41JBSIW/b0hVGVZzrt8xd2ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6+tWkhX6jhOiQUCwv1WSxaa6deQu2bTySXUJMqsEym9uNgE7T
	FmXQReyLDo2dry0ikEDLVMCnz48Or3LmSii4z4fq/alCYG1KdWNdmUArsbKE2yR0Xp7vdDb/tUJ
	P0PnlUD2WgjLZouwE7z7LTPxzc0jBJZJ+l4jYbrQXx2YOsm6cep9B6PLZvtY=
X-Gm-Gg: ASbGncvp1PBP/YfMihFXK6zZp9xlUhqcA12Qd9qzb2P7cyzk0zX62X1jdM21cgwKZzX
	chPqTEDIZpamNlXwPVvwHc9U7NaF7KybDmGi9Hn5F0Z3Y1SksA3YqENm8Rjj6hy3cBFG/E8BiLa
	fccjAFN/i1je1gxF/+dReR+zWo5AA3bYxsMfV0J80Tmt48EAoVWYk+CkN8VDgTBH9ALRtLCACEh
	1AmgqM6wFKgDqNUyj1duBTdYp3/6eezAqo4sQLmJ1LATuH4knylKh9NzO6hRUzL
X-Google-Smtp-Source: AGHT+IHcXpaYUvuvHbg97J7ktgYhoFhHlSK61tRa5Gn2HGyAhLpvnvBPUNwdFiKjC1PzNYk9gIJ7lsruTzjTfjL24bQ=
X-Received: by 2002:a17:902:c945:b0:246:61c:a67b with SMTP id
 d9443c01a7336-246061cab36mr14478945ad.58.1755758264921; Wed, 20 Aug 2025
 23:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820124519.2287171-1-abarnas@google.com> <aKXIoFpHUjSdCbHY@smile.fi.intel.com>
 <CAATBrPGqkuLrVhKi8aj-tugZNVMD3kqv5_v3WB=kJvt4FVtFzw@mail.gmail.com>
In-Reply-To: <CAATBrPGqkuLrVhKi8aj-tugZNVMD3kqv5_v3WB=kJvt4FVtFzw@mail.gmail.com>
From: =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>
Date: Thu, 21 Aug 2025 08:37:33 +0200
X-Gm-Features: Ac12FXx_26dv5aIj5KUUthDo_hXrvOsEk58zD74CpJhjgeW2kMIsNLP7aELjdNM
Message-ID: <CAATBrPHZHtW0Omp=KRskunP_2QFezb5DRRQXiCFzW0YzQcr7mA@mail.gmail.com>
Subject: Fwd: [PATCH] staging: media: atomisp: Whitespaces style cleanup in gdc.c
To: linux-staging@lists.linux.dev, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan, Greg, Andy

Will fix the message and replace the tab I missed. Also will refactor
the unnecessary forward declaration.

Thank you for review
Adrian Barna=C5=9B

