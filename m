Return-Path: <linux-kernel+bounces-766926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4983BB24CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB409A14FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE8A2F291A;
	Wed, 13 Aug 2025 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StbyTQ+f"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D12EE61F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097122; cv=none; b=JvjI5aBKpDieBtEC7lGxQZO3/TIleTCSydgCyKu6gK23S3ebqJbuuaFs91Oqf0ey0aBzIkQGsN7WrGfwNyZJWT1aO+rC+fIB837DlUrjOfai7aM2QFIkCscAJd71eBzKV5NyCSqaDkZg4llx8yd3asX9mjs7zXqD9YTaATs8id0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097122; c=relaxed/simple;
	bh=cdj+KiCbn1oJwqYp1Ud6yUCBUGI3vXG9Hhhy6pT+YGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1J9JnQa0aAd4X0rFYIkRYEpHO6pZyK1DpTjhgkzwX+t75AeMzfALkj1Z/8vsMVeTnUU3M5YvRSZEN0tA5dYKYLG1NyTuAHgDBi/zbZKq0ktjlg5IVpCN6kWTXlA0v9kA35faMZKARCvD4ZTmA1luGHBhhkSsrRqRd4xBoVEseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StbyTQ+f; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-879c737bc03so167967839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755097120; x=1755701920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdj+KiCbn1oJwqYp1Ud6yUCBUGI3vXG9Hhhy6pT+YGI=;
        b=StbyTQ+fIAizQnsHBGcc5Z1PFWQLOifdN5JgnxWAr2v9BBGVU4czvUSLMV49tgxzMc
         EI++wcdoakjG5zk3xzSY/u8YiIuRZM/UTOYUffwHJShiPnxqhvPAV1awREa2P1s1uEkv
         wSRJG/bfkPanX51jMsJ6lBogGgZlzU/tYChAdgCkBLBfwfbydkOCZNM/GovkK/kyN58a
         0Lsex7W62fMulbNls0MUjGzDO40/Et/1qtKDN72tdKHKSHcpY07ZGL/XJ0S5ZOtoEDCP
         ycaME/DlqpcvnpOhS4glFl5fqWnHWcOLy0u/OmCTw9XRTx0vYQhg3wLTXymKpc+txs5/
         ovEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097120; x=1755701920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdj+KiCbn1oJwqYp1Ud6yUCBUGI3vXG9Hhhy6pT+YGI=;
        b=ij0tOdzf55zJb/e6MUW0aU8kuIox4EswKpJt5S6bq40gvaSkvLsvY6vaV0yVnugXmt
         kMviNigHRzIRfJ5o7IOdfb2THwiMmV/883+dO/yOh52LBFgJvN6GL+U+rrS3cgDGy8/+
         2lEPpi3Qn1qs/lCkkTpNwyHlJPWd0MA8L3RZTUUEAsILcSJSK7fTAdmFo5ZT9ndbExyC
         wpVqkUPczlabhz9b0rS1fMmRjBaKFlvOh4P9ocgVmrtYAwqyBepOMC+cuvmjru0HDXZH
         s9F8rCXDrSHQOr5FMfehvrUXR/GehOAX8QR/xNF9SEkX3ZuSX4yoacS//PV2nafZd45Q
         gEKw==
X-Forwarded-Encrypted: i=1; AJvYcCXN0w2xx00jnj9j3RSh4TlGDyVSPodTLz2uMK5g8X0DPNlsUd2zD/WpcW6SeJ7yXaYet3Lrk8y9TjUqDnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhpzqYrT2MlDSzJz5mGcpWvsATGv9eOsnUVGRePhXP3vJrV8nH
	VUT97ntdwVPMI6eTe7zFIaWgR2o/f2Orf3PpN1g/pJ1Vk3tdAOSL2tzWqz1OSUIfyDzo3TMH8kz
	11dHa/4MgsYLTya5+XmqbQjGIQ9IWDPk=
X-Gm-Gg: ASbGncvx2dZy3ifcyr5uv8Wn0njaEjuDKzMj3a27z87PM6Ey5u7bR3CVTQf8kjDOXsw
	+jJFmsyFEQ60jHVEEVnPWIXBvqN6NyXzPnV+DK6rGqUE+brilgQtHkX2nJQ2bwLl6kptg8vSGX4
	0Sw1qXpV8baazbU9u0NJmMeZuPY7Xylx13DhsjElB5cgHWV5ZvWPYmUr6DMEpKkpFckcJ1rFPsK
	Xn/
X-Google-Smtp-Source: AGHT+IHLKYWoLQgeaa8lpUZkBDSOBm6JTFQBeQSvjC9Q22Wk4nofbygD4o5PAkEKh0CzR9uDm1gnj7nWtx8MBs/ueCQ=
X-Received: by 2002:a05:6602:160d:b0:881:99eb:e212 with SMTP id
 ca18e2360f4ac-884296893a8mr594614639f.9.1755097120122; Wed, 13 Aug 2025
 07:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-swap-scan-list-v3-0-6d73504d267b@kernel.org> <20250812-swap-scan-list-v3-2-6d73504d267b@kernel.org>
In-Reply-To: <20250812-swap-scan-list-v3-2-6d73504d267b@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 13 Aug 2025 07:58:29 -0700
X-Gm-Features: Ac12FXwhCZMD2zvgw16nmysoWddi5UuKHvB6gp_uCoNluS02s0CWA3dtY7J3FTM
Message-ID: <CAKEwX=MkZ0MeedMdjczsuwWLEyj2asZsvt+2Vk5evEbRTZrh9g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: swap.h: Remove deleted field from comments
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 12:11=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> The comment for struct swap_info_struct.lock incorrectly mentions fields
> that have already been deleted from the structure.
>
> Updates the comments to accurately reflect the current struct
> swap_info_struct.
>
> There is no functional change.
>
> Signed-off-by: Chris Li <chrisl@kernel.org>

Acked-by: Nhat Pham <nphamcs@gmail.com>

