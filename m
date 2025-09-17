Return-Path: <linux-kernel+bounces-820492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F877B7F853
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8258A16571D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BF22BEC2D;
	Wed, 17 Sep 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diiuz67A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5A5278150
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758105253; cv=none; b=WS+igCk1Q2LuTPM1WmBvQaYl/KMmmq+POfwYpBRnUbiqHtWY1H7RrEq67s4MMFxUkkznuEuUkcybkKpKVJIEiOZGZB+lkOej8EnoKC2ZVJQV266Jcc5EpYDtRM215rPFvS4mgbniHB43PWqwh3BFb6+bga627YuHZ/RLd0sxqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758105253; c=relaxed/simple;
	bh=1cBxv1xbY8Fpy8oQcvISFXu2Gvy5Sux1+zhD/ZCpP5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIwh8Ug+qsNFLgkaPAy1V2iqW1wsoWV80/oj+skgG9WasUIIUGeV4IxGKTmGI5+skM/EqqfbhRtTz/GefNE9byn8jlCkiDCNhHw0N4qRrY8+wH3DG/ufbbKf/PLz9t7XFnfjkw+8mY+KqiuWQfOcQItKt+dOm35CRikvE80L5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diiuz67A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758105250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cBxv1xbY8Fpy8oQcvISFXu2Gvy5Sux1+zhD/ZCpP5Q=;
	b=diiuz67A3GAhUt1E2g79iZE8lvTIdYx7A1I6OA4JVsiobHXvIsxzu/YLDK3niOc0YfBOtR
	FfuU7wb1L18YEDVerkoeCMhz5es6hwbp5ahq1nwQyA4z5l1iSnGeiz8T7gxJV/vtkhQaGj
	6iS0E7dpB8a9YqhPdbZqu4+/nPwgtGc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-DemHZIyAPxSQcit3hzhtNw-1; Wed, 17 Sep 2025 06:34:09 -0400
X-MC-Unique: DemHZIyAPxSQcit3hzhtNw-1
X-Mimecast-MFC-AGG-ID: DemHZIyAPxSQcit3hzhtNw_1758105248
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445806b18aso64805945ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758105248; x=1758710048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cBxv1xbY8Fpy8oQcvISFXu2Gvy5Sux1+zhD/ZCpP5Q=;
        b=HCmU9GCcDLzsJjIHv3ZPcvFFYaYD9XSc8df992+yn1I6UoVGnm+6gtYsC35Zeo3N9i
         fIzw3AxIAfWjlPcwo47Hq0ReuJL8grmGj0IGjbJyTFTxF4p8IQe6xZiRv7KNtzaN8odl
         bdZp6ePtNKObNpuiTtlUnTLzoZ5c/SbAa6xBIQ+hv3gj5MuxqC5AuyLSqHwuW3QpYoiJ
         b5hUipd8KETBd7M97l3haHiV233K/7p5Ln8DcDtUVJj2WND8wkvYv1O+OybRiwPT0CS+
         I48IlFlE1UeUgzbIBEsAjc+ip1wQSvY7q8h3mVOEGLDVPaL9SjNErpw5qolc+4Dxilg/
         Dtww==
X-Forwarded-Encrypted: i=1; AJvYcCVNw1yvNaayGhUTEBnwLS0OOIFAWI7cRltSy/zrfoqCL24DbADWHe8YdoXyFfo9fLYnsDEyjlXhKpc+t5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTyHpKLNc7LkpSfCXlS6WmRJAtO3e6uiss0O9R1Vr1Qj9r9h9x
	Uk84/FLoo0nwJQBGDt9MzzpMQlkaoveDT4CAzpcMJoZmA82Hg++jGJusW4UR7STFkGjG2+ubiCc
	Nfikvkf9L3nMHw+R6Gke4DjiS9iJ/U0ShQ7M1PwD/6jwKLECoIlQwXj5H9hPJj2J7yBX/Q1aSQb
	wNZuXlxXjdEas72HXrc9qLerN+EKgH6RGxHAYtvme5
X-Gm-Gg: ASbGncs2YvGbgbMCWaJDkp596TYtyQnZbODbOYYQo6eFrLhilGbcRKIt9Vi7n5ETaTN
	Br00lCYtyV5oI4x5705F1C0ReQuJo6gQ6sLSVUoMyD+K1wSFdtuxED7wRQOUmU58T6EucfoL4m4
	ExlcOj0KQLJhemeTs3+1A=
X-Received: by 2002:a17:902:c408:b0:246:76ed:e25d with SMTP id d9443c01a7336-26813bf0c6bmr21731685ad.50.1758105248311;
        Wed, 17 Sep 2025 03:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2YzbN/E+UopYldHCixM+VVbcJJcmpQWL8AhaVK43uVZhoyGaM4rEdKN7JZb5lpF619POQOSbhM/3uAXXs2eU=
X-Received: by 2002:a17:902:c408:b0:246:76ed:e25d with SMTP id
 d9443c01a7336-26813bf0c6bmr21731485ad.50.1758105247999; Wed, 17 Sep 2025
 03:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916211108.1243390-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20250916211108.1243390-1-kriish.sharma2006@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 17 Sep 2025 12:33:56 +0200
X-Gm-Features: AS18NWD1T2FGHwQjVZMQL6NQNbpFLaeIpEjOA39LSJoQzn1UTtglxZVkhl6gbdQ
Message-ID: <CAHc6FU5qWAY=aUjZ+YwwjteWCanNYFZW_xpDbWHkJV99qo=W=g@mail.gmail.com>
Subject: Re: [PATCH] gfs2: avoid %pS in pr_err() fallback to prevent vsnprintf crash
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:12=E2=80=AFPM Kriish Sharma
<kriish.sharma2006@gmail.com> wrote:
> While debugging a syzbot report, I found that the %pS format in
> dump_holder() can trigger a crash when we end up in the pr_err()
> fallback path. This happens because %pS goes through symbol resolution
> inside vsnprintf, and in this case that isn=E2=80=99t always safe.

I'm unconvinced -- when and why is %pS not safe to use?

Thanks,
Andreas


