Return-Path: <linux-kernel+bounces-823755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500E6B87616
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7850D621ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F26C2EAB6D;
	Thu, 18 Sep 2025 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT4tzB/b"
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043BB2820DB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758237886; cv=none; b=a8AXUBHpq5umDngol1fcAjv8fzyr+rFBbGzGWu+PBJyLLyDQYKK8hSAJRlLOOmbHe7Fx2CnMyD5krxUYIBXb+uHPZBb24+6346f8aAgWymDlLcxup4JLkUmzGrciFpqVUUFD1+EG18v1c7YiBnScKRoZ1mIxFDe3MeJ/V+6W5Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758237886; c=relaxed/simple;
	bh=KJ6eDJFZIq1v7BWaE8E+JtTKTM/ntkeLT86o6EjF27g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnisWfFKvu6/QpWr9mu4QG9Nx4D8mxtCjfd7ZumoObV4vT6gl63ci6SwKqh8JoIYglsOt1g8AmUmDVHPvZnz4bj0ToKqJ1fODKGj6BH7MV4/qgzyFGkEf+GbYDpupOdr5BSn7qozbs0Szrwa9KcYKB2+YVkQnLrycwTFG0RlXCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT4tzB/b; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-632846547cfso790769d50.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758237884; x=1758842684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CvsGel4kr99TW5YyyaaFZ7yb3mg4vfy3/AwN3gMDYlU=;
        b=ZT4tzB/b0FXWbXbc4V5XpQR9izM6DXvrc5SrRLsUUX818wRaNDjqnk8kUUbIyKl7TB
         JYxug4LTXl1GfvSE/b4kDPN+zeVsxWq4FcLcBhQHE7YZ34L3zrNeAy7qFxPcTHMP3LzE
         8fEt9EhTUQOgk1iaRMeVq2ELT3lfxYDP0KZ/gL6lNxdETlTccUtZkbVkQ668a0ySxqJo
         JCWcc1LLJH+IZuXvmGDK6uB4vn9iH8mVM2JWtJJLPf0+wBRdErOfpASUR5W9/8/8KS/9
         9byX8FSKxsWamtC4RgI07jw8S0kjxV4CsVSCi4lhx3PDVvXMgmTV7K+SQhkvlrk+PruG
         iLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758237884; x=1758842684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvsGel4kr99TW5YyyaaFZ7yb3mg4vfy3/AwN3gMDYlU=;
        b=L8u4p3ecOMsNDovPF1LJFaPE7XA2l8vh3ihObdk0LtGOROHsjFpNWkJ9G1CwgMpT4m
         pxr9ZFfTS/Nuce1Hey2y8Z89C6qTd02qyCgQiCbs3P5NXyTQ3LDma/C25S1S1bv46tbT
         Jkf12Ngwj1Tr6azwG3e601NqyVeIn0ZIcAbX/FI3onxFrq+1QMuzjSsdctAqQF0K8TL4
         mYNwbWdGRlnvUPkyYdQeHt1ZPWkk6ZdDmenB1Vtv0aawse7IgNNFhGWT12CIFTrNNvaq
         lEyJQeTkpa4VsSqb67FPkBk7OHainbKUeejZUZAyBFgyZCaPfCsGMIRwsoFU+FrOf/jj
         waVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi8lFgjRLUil3jSKNXotc5i7N9vZLgi3s46UVQ9ZnE9weJqSqmmvAUJ8IvcP4hsE2UHzc7P5YsoBrseBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWQSRDY1uZQn/7DcHxPxbkJkgAf1Qqz/wg8QV9HQf0dZz3m00Y
	z0mIp++v+fqaAsc19MCUR/EhuQX4Sybi7zLdPW80elr6DGl7XuvKNj6zx7LSZ4/JWha4aq62VX1
	qOfSw9euhCsQ40iN3ZLzGAUUkfToFUJM=
X-Gm-Gg: ASbGncs94VISBLWXp8u05uB97WIGArv5s58d7CbQ2eJoVijfI+2J6KtG+qYEKx7EZ9L
	opeeATSfRTrjpyI0vPhgU2sGwulpZra88Qdwlh8IbBw/SqbTzHVpzGQsIn71Hzg4061/fogrrkO
	GMe9OyDN9Jq+OF/AUEVBjlR0W5sDF/sD45NZGWdBL9zauv8MqzYpCFNS41KFQ8RjT2LnZmnRN8U
	xlqegIskvW4eVxSm8C3Pjk6Z+8=
X-Google-Smtp-Source: AGHT+IGnlRT51Rt/EmIV+6PuLeofyi5CG17OdD1HpDWJozqBX1ywLiIjRWssfaPB3W3r+0+fH94losGcIjmTdT9C9/U=
X-Received: by 2002:a05:690e:d50:b0:62e:35c:f4dd with SMTP id
 956f58d0204a3-6347f5a2ce8mr1145514d50.28.1758237883961; Thu, 18 Sep 2025
 16:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917141806.661826-1-yury.norov@gmail.com>
In-Reply-To: <20250917141806.661826-1-yury.norov@gmail.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Thu, 18 Sep 2025 16:24:30 -0700
X-Gm-Features: AS18NWCx6-1PZIfOInuho6Ua4GZ5_d0gdGjoTSTVK59NruqS-sIn5SQORAc7xug
Message-ID: <CABPRKS9mmUCig30yz4DE1JgAkS+NejeZwr74rd80F5actbS6_Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: rework lpfc_sli4_fcf_rr_next_index_get()
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: James Smart <james.smart@broadcom.com>, Justin Tee <justin.tee@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yury,

> +                       if (phba->fcf.fcf_pri[next].fcf_rec.flag & LPFC_FCF_FLOGI_FAILED == 0) {

May we change this to?
if (!(phba->fcf.fcf_pri[next].fcf_rec.flag & LPFC_FCF_FLOGI_FAILED)) {

Thank you for noticing and implementing the rework.

Regards,
Justin Tee

