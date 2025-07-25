Return-Path: <linux-kernel+bounces-746011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2FFB121E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063EA5452E5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3042EF2BF;
	Fri, 25 Jul 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXaNOfpR"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3272EF2B0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460581; cv=none; b=pMPgiS5y73RhjpOmJMXKEpAsJ1I6HqB3r6iBrelge2EQvu24DH5zA0CqytrHvfzU9vVhyWhUyYW3thHlqoOJL883ItopF7xwIprNJs5nbPqNx6TPeyeWqSHLka1OunZtdMTnOyJjDzXpjcOsLxx+CBNU+qnhuutwgill9YCBXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460581; c=relaxed/simple;
	bh=WgMMn6ZE+UO+Db+AMvscSv4rxcyxcz2YSvR/V9F6PT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1rL55BFdYyhHXGNjpTpSHBnK89L0ySjpvgMfoqWKUfdOG3A5DjM5Bc/33voe8os2i11y86sNgpZncpQzggXGY12OqwV4gg/QZfWbYRXmhxch80eFvV5U7JK1GTOesyRD7QAIWGudv2WUyRft3P8bH1dmDQZAIT+Ddyn/HQsGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXaNOfpR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab3855fca3so306731cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753460578; x=1754065378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u74rPH//c6SnB7FAtWzTEu0clYtboYSpeyULU9wz9Nc=;
        b=tXaNOfpR9sWnUoUjbkXSln7zcUFDRoi6napO683fjHQjt9bx9ZVAb2O13Dkv37VyMm
         gdNhpTQ7XQeOVsm/pG5wUgo3J8TuisceHl7BIwrzeWDKb9yEsPoAGjiD9u1foffyOw0h
         1pe25RqtyfNy68FjfUm5/vDW/uEIklqkUQLdz+xIGpiv/9cusEsE4J5BhVksGx3iE/t8
         IUGCa1aAFTDtuFH+ij1eH1N82Um9/fkCdmopOWAuAT+N/RzAwwiFdpwSFoLeF8C2ToIi
         Oz0St4OIuDxzhla93b9WajOTdd58yFQ6BjAtnnzPDsJdb8P9otlqUH1qAoxpeO58k7k9
         CZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460578; x=1754065378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u74rPH//c6SnB7FAtWzTEu0clYtboYSpeyULU9wz9Nc=;
        b=XiroPtMBrLk9y/pve02j4h0LGSDWYjgLNibaTk6Xl0EVmKOem8jOsSpMxhbXMDg0P6
         nyqJDHo/OZi2Si691CuJr/9aIwIvwoxDKDnoP5A833+I4u2t7+2T+hWxhSpq2Ii3G8oT
         xtKfH4WRZP8RRmwQBL9/pXBWmcMSU/pzugsgDV+9a0yRaQxzoG2hvFhSa4ZJaT0Gk6Mg
         gDsHmOaTylvb0qk3tbvQ4ihOJvc4f2w8kN6Tr2rJzMb2X6JW3h0V7La0ZxNZSHXnOA8I
         O9i/UXFSqKLrUq5IRgww7d//1Hfw/Z3NgsKJzH+WPm+UU8jE7KqzHStUwHQoF/EBppO6
         ZehA==
X-Forwarded-Encrypted: i=1; AJvYcCXi257377ZkeEu18w05B4qiF8r+KxpZKoB8jQUN4HeGF1ZbUpJsEBT8ahet+m3bJ/gGPpKFiTykQNzF3XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws1sK9lf6QV6Naq8dv8Q9pTQk3gWwHj4YyiMX4pfwVWB/zPvNt
	uQpP84yGQ/suYr2ZSrDn1dm8vkvmbK0/+Yk2GlyAazONtzuMDWq+ybIdKjPWjjyF7Y+9CBDnK8H
	a3kE683fuX9pvNQm3b7Clj57i1PFIIykPi223KJHH
X-Gm-Gg: ASbGncvIn9Ccw2mjBweO6piPz/eA8xTwGiUhYiN7gW2WsmNQtHzRS6BieYlpCG9p8l7
	LTYvSc/2Y+4KnriTuxaLxskWDOKJyhH8EUTwJmbsxZNsNjbRIVuOjqhCLK2tMrVwPWEtK/cl0zE
	hE+Qp89bI3RwgFxMCcnZR972VKp5J2WfGjQmTZNQn6hA6F+w572vIhD9IA3SKhkhQxRYeu48iZN
	ngyGRg=
X-Google-Smtp-Source: AGHT+IGD5SL618OivdHgf3YPz/VJY7lvtmasgb/RxMGs4CnSxgWUrrNPAHtyRyqEw8bJFf0csvVrx4dlWjbdmBruZJs=
X-Received: by 2002:a05:622a:1a9a:b0:4ab:4021:b919 with SMTP id
 d75a77b69052e-4ae89f706d1mr4756631cf.26.1753460578147; Fri, 25 Jul 2025
 09:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724235144.2428795-1-rananta@google.com> <20250724235144.2428795-3-rananta@google.com>
 <aIObyUg77Um6VB45@google.com>
In-Reply-To: <aIObyUg77Um6VB45@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Fri, 25 Jul 2025 09:22:46 -0700
X-Gm-Features: Ac12FXwiy_BB8KHm3Sk8akfrBLEAKIqgsoVUrcDSZxShyAtLyS64CyISJLMjXEY
Message-ID: <CAJHc60y2-NvkyaUEsy4hKnGTwQy1HJSa_Mp08xfyeQkvTKWn2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: arm64: Destroy the stage-2 page-table periodically
To: Sean Christopherson <seanjc@google.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 7:59=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Heh, without full conext, the shortlog reads like "destroy stage-2 page t=
ables
> from time to time".  Something like this would be more appropriate:
>
>   KVM: arm64: Reschedule as needed when destroying stage-2 page-tables

This definitely sounds better :)

