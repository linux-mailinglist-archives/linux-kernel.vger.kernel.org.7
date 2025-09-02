Return-Path: <linux-kernel+bounces-795586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3B5B3F4DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9195E485530
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A909A2E1C7A;
	Tue,  2 Sep 2025 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEU8fKtA"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097E2D5945
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 05:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792453; cv=none; b=o7owZdy3tTrk5saWRgFdaTqjeYoObALaa0c9wpRKuKKV87sKjAd8DjKXL1nKZW5bTVuWIOJ7qQMmVcGdy2YFz1ENOGcqqJPjTRInvAg4i9j4CQHhOKeXNnF0orYuk3XUdHazMIO71gO8hwSJsdi7IWTWA3jpUye8uK85ThHqJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792453; c=relaxed/simple;
	bh=isJs+BSpnFMCJQiep66pO9WoCa8BcyekP1bcFIWYWk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7yR6PlxvnMkNDl7YD9SnqbffC9i3HKHh2NEcjT61sv4ox9kSUKoGIabbbO/DYPbVWQu5ROJ2rysseGAmB4oPW3BPY+EhVqCsI9SICaBub7W6SyN0CnMkv88OcMMRkuRY/Xg93b99Z5nL/+SLMTvy3Z/aJJlrX9tDe4BQ07zafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEU8fKtA; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b32384e586so18907491cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 22:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756792450; x=1757397250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isJs+BSpnFMCJQiep66pO9WoCa8BcyekP1bcFIWYWk4=;
        b=mEU8fKtAJW0xq2RttDcFbbWubvmsJM3ZIcD9yOdSXPhzrTJCKifa7nVfdijmlFeCNQ
         WHqxjOfEtedVW85yA3KNQbwY5ktCjlo5h+Do175JTSRCVDqOCukWHrLc+lbK3D7D66TN
         4oeIF4QQp2W88aYpPtvSKoXhNgdwqQejTzs6APtEoxU7Zy38a2tQciMwLFqv0JutDD2l
         iHIs209WekzadKjA4c47WmieuN6tTkoP+aEPImzbQuaFelBEuGcWDDBQxlTOFNupmsl+
         nhndiodg3UWR+uhL/+Gn9A4G8OQCIaWG5P7vE5rR79EIqu/Nrp7gP0g3gcw13hrpG+eS
         BF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756792450; x=1757397250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isJs+BSpnFMCJQiep66pO9WoCa8BcyekP1bcFIWYWk4=;
        b=K2H3fHvPs/iARtUO4WZ2GTmX7+Q+Z1Tspj71N8wAGPqFgBeWZ1XpIMMyRdATB+k0Qc
         qjVnL0EV8mwVkUmlmiX4YIwphJJ4k5P5nd6u3tTI1syqvmTpHKJM51i+RDooOPGh9HS2
         gIdMoh4FcZMlNV2VAfS2Gy+3BjyCs86Db8cxDXm6L7766oVK0g7ha/oc6KZDDM8aAjA/
         mW8j/tdzN+f7ZPEHFLTIK1rdv25TCmdiU7SRMNcu2eradRoO3OR7pRrOPbFuenygFM47
         QFZYlweHs8yU46eFM2OHoH+9fLJrvuv4geUbjDU5XuXszk0rRW2IjHlw2K+TDrX+7OaH
         AZdA==
X-Forwarded-Encrypted: i=1; AJvYcCUpB09MgCep+qaTeXrCBmUh90LsS4aIRqzR+LsFRr/JSYdxepRW71MrYSVyzAE5Q0vf8oeNbKL+PriTeQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSznOrvyEvvUxkwikwxeCHpj0umU0xVn6e3HsxqYYmFcALUte
	gjfJFgtRA8bXLCcBhxVPlAsngjHkpmuPp+g86QPsoqYU6WP4g96EXYiUoIAaKpHlcl5pSPwZ68/
	+pB7RyM5WaemvdFL6JeQMoY+8ayv3vu8=
X-Gm-Gg: ASbGncvWhr6//4zlfHGxCXqJAgGmHjtGgWJtBhk4TZsdElo97bbUIRaOb8D+XC8Kd+g
	FKOFu96ecyUlIEd1/pIsUYFXd2/tXTVaIWex6HOUfJfj+aEJozTCD8w0YWUQiti6c7EjSob/mkv
	6TEdsFF2KrH/bCKQO0lwXN2UYdVy7/kVZKDfsFYvmXVR1gtRxGw0eBgLfLbPMgPa5d+zUQdfb6v
	z+2dct7hf4S/01Ljw==
X-Google-Smtp-Source: AGHT+IElPYmrO2JTFGTxjWDUyyjx/DqHnegvZw0zz/eomd0JGXG5A2ieS/dE+0dPFtRgsGk2qNXut+znFJlw1YNJHwo=
X-Received: by 2002:a05:620a:19a7:b0:7f9:ec3f:b047 with SMTP id
 af79cd13be357-7ff26eab6cfmr1062526285a.2.1756792450289; Mon, 01 Sep 2025
 22:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-4-ryncsn@gmail.com>
In-Reply-To: <20250822192023.13477-4-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 2 Sep 2025 13:53:58 +0800
X-Gm-Features: Ac12FXyFe9ctWfEergz03QTYO3jAelSmUJtD1XyEOo3ep0a_AGCh0AaSBPxGPJQ
Message-ID: <CAGsJ_4wAPV=K+suQC+jXwa-vY-TXLECTfR+zeq031o+G1EA5nw@mail.gmail.com>
Subject: Re: [PATCH 3/9] mm, swap: rename and move some swap cluster
 definition and helpers
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 3:21=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> No feature change, move cluster related definitions and helpers to
> mm/swap.h, also tidy up and add a "swap_" prefix for cluster lock/unlock
> helpers, so they can be used outside of swap files.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Barry Song <baohua@kernel.org>

Thanks
Barry

