Return-Path: <linux-kernel+bounces-822450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EECBCB83E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0190C1C07326
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3DD2EAB61;
	Thu, 18 Sep 2025 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KM21fzvV"
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597CA2D593D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189025; cv=none; b=ld1ik5ye6uHmhtsrnEqp9udHQIk1WnPY3YiaVb+ctpExHeNTeVayQ65KEua4e6fhGlBiNbhBsck5NwMjDnbbm2tlVP4FY22KWzA9co5rd17EdkbV0u2kbMtdhhvAnQYAssDEEXosjOWfMwJmhE0MVjSOi1SsXlW8wwfHe4OTDpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189025; c=relaxed/simple;
	bh=sb+/Rw8sIjYpdBKb6sxmFtn4/XkCevzzUuk49q+M4u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKBJGHGxvw9GVddfIG1mD0voT8whEJKoX/pDuVpvgzMmQBsxfvZA9AY58yBnrwBg/LlbLMt/quERVYkqBxaazNF+I8bf8g/mLMAHp8EvrIaQ4nCm9C/TDnFYaIjeLxqnkVkEmRC6zP7f20BT+OuXIqyWJugTAywXjglSpKSHQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KM21fzvV; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-78f15d58576so7220486d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189023; x=1758793823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sb+/Rw8sIjYpdBKb6sxmFtn4/XkCevzzUuk49q+M4u8=;
        b=CbushXQZPTdGbRDQxoE/2SbhAWO3xn43homASQhTThX0pqg6LW0XdNhQGL2kR5o8pL
         IjMgEXIcI3i+Pq/OcHW0dwb3OXxPO1XwqoHGRwtxOYxF8FXZlLVCtcfCvIM22ro4oI2I
         m6CI+CrDr8nBJ5NxVLB6cD4Q3GA425kDXbUsDgYWV4R484991KQOOOlTrD8VbOSi1Ps7
         sey7zMqWsENBHy/5gAqrYzqHX7ZnJp9/xqCS+Hwp8YanQ+mXQMTVwxaczx69n91ALS+z
         l9aIdKKJrPkFcgV6jZ3WS3jB0FGCWHbrBESrulOGasAK4rmNsPrHsH19EAWDSupf95ro
         yM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcQPTBsWhTri/1UaHGmPQtuu8C08/lKz3iTo1susySkcSkRX25BC8YlpTvvOgllUB3XnfkNZQJyDcm3WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUaHqRsicLceq578scieF34nSVhxzDIN7vEdIH+uCbW3UIk5CS
	ZMTDZZNQwlcEDuy+fT55cAwYfghJh8w/h/eKrbHYqu6H4O233Njk1NYA0YCyabqwF2XyyRR8EGQ
	2BUcAFPMWLTtotPEOhL1Rkd8LQYnX0rINCE9QXtXqk3PK72rX8rnWtKRo8DpxIWvQ7zXq+NffO2
	zm6awI3QarwBbZovpk/q7MLWtl2RGYj0c6m6SNCvkuT9QzpJYNLJfw46GBOcljUZFqUG5dkpRFQ
	V3k8vAS/OR5T+tAnqZuiK5g8A==
X-Gm-Gg: ASbGncsYih6stW+CszEJa7r+A3EKad1rQEsvxJeaY9vyTFMSJOMSy0pgSAcPQDrMFWZ
	R+BfA08WuwVNyYYUMbJgwSzH0L/quwtM/XSyjsdVedKxDV3jTEGYz/iEfM9QN/rjq3OJhmJ+xrR
	4HTEZ3ERV8pVqHskZvQU/m05HWROzNFaB6FmyhT4lh62A9/mfNGzVyN15aiBUznJr69NMBK+ETi
	TZwFEQ0M7LOjnXu6Nt2DtmUfFktOWsVpIKn3xA1+BwrxpRbVhMiOTY7eTd+LAQd4ulNy4G+0SO6
	jOvmnLpYfSROF0P7HucBeOIRe8svKtnlE8c7GKV0NiXTIz6hJ/iQVakc+Gza8+oVjnbt951Kd5U
	b7TuMOvP2qq4AN9Xil1AxyJpjauxiW0+qwwoZJXOd78YH+WwdUZwOq6q7jQcu1ezf/qxJg3ZhrQ
	HvzTayJ7r7
X-Google-Smtp-Source: AGHT+IHOVNXLSfkVWRN+ByTEG6h7DLMy0JPXDF9xk5Ye2cYVOABE5U9IF9b1yzJygmW7+YgcwbdzwiVg69Vn
X-Received: by 2002:a05:6214:1943:b0:78d:592d:fd03 with SMTP id 6a1803df08f44-7926a5f662fmr28446316d6.25.1758189022825;
        Thu, 18 Sep 2025 02:50:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-793456fee29sm1302476d6.13.2025.09.18.02.50.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2025 02:50:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2697c4e7354so8480185ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758189022; x=1758793822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sb+/Rw8sIjYpdBKb6sxmFtn4/XkCevzzUuk49q+M4u8=;
        b=KM21fzvVVwHg2duGzac7XDvOFaAxLbGjNPwMu6V+M4hFrrK6T9FgdHrJ1k1hymYQnx
         q7W3KCGRvqv9xN4R7FIZpweJIJPbnNNiCl4QtfKKq7JLvoQOm/vp7zkcxoF5jASdf2qp
         4ebLoHs7xfWoeCi2ipK22+3FI32+sZuefb/Xk=
X-Forwarded-Encrypted: i=1; AJvYcCXufuhh4GIU+g5ptEDo91rACP+vTYPPD0vmgBih6jzWlyfmtMOoLnOuT3nmMuNWpMoWcQyViLMAOICllbY=@vger.kernel.org
X-Received: by 2002:a17:903:1211:b0:267:8049:7c87 with SMTP id d9443c01a7336-2697c854cafmr35711845ad.14.1758189021693;
        Thu, 18 Sep 2025 02:50:21 -0700 (PDT)
X-Received: by 2002:a17:903:1211:b0:267:8049:7c87 with SMTP id
 d9443c01a7336-2697c854cafmr35711605ad.14.1758189021293; Thu, 18 Sep 2025
 02:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-2-bhargava.marreddy@broadcom.com> <20250916151257.GI224143@horms.kernel.org>
In-Reply-To: <20250916151257.GI224143@horms.kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Thu, 18 Sep 2025 15:20:09 +0530
X-Gm-Features: AS18NWAGZjI9AOoElZ1PqbtOBjTR_Wkcn8OAuWFBln13azhgXSnyquR6Rl4ZLWk
Message-ID: <CANXQDtbXG2XjBa2ja1LY7gdALg-PnEyvQBWPAiXQqD0hvtwp=g@mail.gmail.com>
Subject: Re: [v7, net-next 01/10] bng_en: make bnge_alloc_ring() self-unwind
 on failure
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, Sep 16, 2025 at 8:43=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Sep 12, 2025 at 01:04:56AM +0530, Bhargava Marreddy wrote:
> > Ensure bnge_alloc_ring() frees any intermediate allocations
> > when it fails. This enables later patches to rely on this
> > self-unwinding behavior.
> >
> > Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> > Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
>
> Without this patch(set), does the code correctly release resources on err=
or?
>
> If not, I think this should be considered a fix for net with appropriate
> Fixes tag(s).

Thanks for your feedback, Simon. This patch doesn't introduce a fix;
the code already frees resources correctly.
Instead, it modifies error handling by changing from caller-unwind to
self-unwind within this function

>
> ...

