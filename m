Return-Path: <linux-kernel+bounces-847983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C98BCC357
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812A9188BC93
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB8D246793;
	Fri, 10 Oct 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZrN/gSNx"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E905E1799F
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760086003; cv=none; b=PmDXS2RFveHvUTBmReTcA8tOUuDBoMme+qODBUVwumofL1kgrTsVz+i0lzuxahU2GeknCBhn6QdrQpfCgDQSECIiy1UQjB4j/HHPSeri2aSVr4uFcpKn1ooQtDLs87p5xU7qwFEmaTJW3/IThBWLLw2j/53D0kl5lrmjgzsF02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760086003; c=relaxed/simple;
	bh=+rr6ptN71+RJg5CEftPY9Y84pnpazaSqrE73a/9fKnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNBxyvhLsRT4L1Uup44AuXv/AiCwZ8skGATHukAsFxuW0PvcGhAJOh7u3sSCClpkubo/ysvjT890EvOAudrJbkh6fXt6n6VXW4HzjhGs2GVZS/AyHTUNzCKqtJ/VubOuGlQX6hRS+Q0W+zso8FL69NFGFLR/oLfdnWO+ySvxFZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZrN/gSNx; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ddabf2ada5so29041941cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760086000; x=1760690800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWPhIahDDyzhnR7dGyYuldk5qSc6Q4CsNW1rZ/pa3uk=;
        b=ZrN/gSNx8OKk0gd2olzDhKXF4nhhbdnG5YRSKgz48fDNDH8UXQR4RT29qtgRbUm7aN
         ekjgasQfydjmShFVx3XVxjzISj2XAH06cq0As9CI53dhHE8CoU1U+kVyCgK8blGLDKW+
         nzJ+mXdkSqDUQGCTaMYGebj8z2iDuY2EZpbfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760086000; x=1760690800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWPhIahDDyzhnR7dGyYuldk5qSc6Q4CsNW1rZ/pa3uk=;
        b=OXl+DFiOLPi3zQC75j2L+sFix0dV3yDzJE9vsr3P0BQXehIaYf6Mvca/tVscnyq96z
         TajHzy4ssOn8Auq3sxYhFfEciE+4tnxmXzGIsbwiYolz2WBoaRboAfnauUcbdNEToBi4
         Bsm4g6Ew47aL6B6ibqLEXombggNsdE+R9V1TyrqRbLtRXNRGd1afDvyaHmxPQfqff1Fi
         EfGRLPcNT0aAB+2nsUsKwHh2al0l5KwxFR4A1B4fsvu0fULPmgujBCoN/U8tpPy++Ehk
         R4wLgySZ6bO8LZ4LVlpJ4bQnVwzVbh7sIsd+GXvraiWr/33SszNjKbEU6PKyrw2LLIq/
         MXbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNdQgsbP6PQbmsFjnH+XjUdxFc1TYHNQFBFSLMIyeGM0HYXp88hs2PFCIgccqd7Nl7W924fQTg77PJwwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjUClurre2hhM9gi7HVVuv5HnI6JSHDoUE0myDSfQQusxLziQJ
	qqEhN89u/sZnoQ39qvx866aLriV517nO1y7E6ul0nzdYI5ECJly7nY60kuGOWmRHWeW4lQhsyNB
	P5yfMJ1ro6xhchzOwFUrUHbpoCS3y3wxOKwBb4WoVUg==
X-Gm-Gg: ASbGnctEDC9ssUsINPWO8NqIVTIvZxv07oE1x+oxGjpnLUttjTJqRP8tKHljxfde3NK
	yC+jSIJS7tfXhFu6sYyrFZYSVzby+JUrZ3wY21X7vo7caiyzVB5xLJcxM3OO5m45PNzLn4YT917
	QBEwfABqynQ5hS0GsbwtRswVi7pdTsNQS+U/3IUzsON98NVEe9nGidyLhZaPWeNslDcWUJd+Pwq
	Acgnjb1Sd+KpY61XUN/fUlg8GKZ4QCdJ2BUQjVGhEhM1WhAWaj9bGrIVmWrv2Y6HdNpADDAyf1C
	OLUCIbrhCRI0vpYvFkxv71cdWQ==
X-Google-Smtp-Source: AGHT+IFY4TmSx16etkLCVGu6OyhbIn7yuReWTv+0QVsBiXOHoj83ViCnGzUw/28cZH5OKA6ECaHSKDxrGsY5snvSJuY=
X-Received: by 2002:a05:622a:613:b0:4cc:b40a:7393 with SMTP id
 d75a77b69052e-4e6eacf6752mr151938571cf.19.1760085999809; Fri, 10 Oct 2025
 01:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com> <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
In-Reply-To: <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 Oct 2025 10:46:28 +0200
X-Gm-Features: AS18NWBRi1E_zl0R2yWgmh5YLqIOEntVwCsrwkUa1T0SswXqubBACHCq4PTA-Qk
Message-ID: <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: lu gu <giveme.gulu@gmail.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Oct 2025 at 08:25, lu gu <giveme.gulu@gmail.com> wrote:

> This should serialize backend reads and writes for overlapping ranges
> while avoiding the deadlock risk, since the waiting happens at the
> FUSE layer rather than under a page lock.
>
> Does this approach sound reasonable to you? I=E2=80=99d really appreciate=
 your
> feedback on whether this design makes sense, or if you see any
> potential pitfalls I=E2=80=99ve missed.

Thanks for the great report.

The underlying issue here I think is that auto invalidation happens
(based on mtime change) despite the file not having been changed
externally.   This can happen because fuse_change_attributes_i() will
look at an old mtime value even if it's known to have been invalidated
by a write for example.

My idea is to introduce FUSE_I_MTIME_UNSTABLE (which would work
similarly to FUSE_I_SIZE_UNSTABLE) and when fetching old_mtime, verify
that it hasn't been invalidated.  If old_mtime is invalid or if
FUSE_I_MTIME_UNSTABLE signals that a write is in progress, the page
cache is not invalidated.

Will try this and send a patch.

Thanks,
Miklos

