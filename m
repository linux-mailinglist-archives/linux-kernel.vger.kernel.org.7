Return-Path: <linux-kernel+bounces-852469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA554BD90FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E813B5ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5A330F524;
	Tue, 14 Oct 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJSj8MXW"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665B52FF16E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441743; cv=none; b=SWVI3BE6nLHp/8nIifhD3KC82IB4mi6LLLm4vhUEAzWLThrUnp/oE6dx8sLf1JiOpOdaYxSFF7mQKy80Eg1lVD6dSdxb4ktMq+aeNYauEt1pfK6KER0XJW7kmcW5uWMHyM9P7AwP9SzDwXwOHxi9JlGrtsiRpErReKqPX5KViTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441743; c=relaxed/simple;
	bh=8p7hD7OCuERyUI780nZ9E8UoPwfcetR3c3Jt+sSRxSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Olb8PBH9u0eFKb6tfhSWtRHo8Cag5LvnrOKQpRA2g7iprP2xv4AkmVYPkbW590B943qOSSL7Yr0E+3uPQBP/7RacqOSgopAQr3ZmFRIGHLS1ROveOTCCbZdsCKlWrf/YMOJZzx90tBUTUlVq4z0EzkPUkS12AoqWEqYkudgJEiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJSj8MXW; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d60157747so51932277b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441741; x=1761046541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8p7hD7OCuERyUI780nZ9E8UoPwfcetR3c3Jt+sSRxSQ=;
        b=WJSj8MXWoFGsLHnYuav86ueHmuytkEDehpYrgwbCud/ueAPt8Fy7qnyFaeyBki2KAg
         KQZM5kLLLY9JTbkfjyB6XK3Ct6itNnymnOONJ1KngftSesjv+Kd8+IYG0j158ItLeUG7
         H3GP4RJZtod4D8LGZZhqNRo9VU/dxoRFg56Z2XZwCHYQDhwKDobOcPjS/C7Vxu1K7DP+
         oMz9NdJ+9obhHM9zkTn93OoJwICYIvUzGjIPRieb7g2wKmkUx+cwBmrzcU5VXiFJm/v3
         KzePsXI/QPXuAXjaW8gp/sYqp9tDgDTaKh/A+8ioPZZJk/aFdwV0Vv6FQ6H+whl7URj1
         QJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441741; x=1761046541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8p7hD7OCuERyUI780nZ9E8UoPwfcetR3c3Jt+sSRxSQ=;
        b=Yp5hTvMm23Dtb+pIvuzxGDSege1QYw+L68TZnsieRJOCYXvzmbAMT380FqCdwYBaWe
         9N045+OEkdHWky9wKU9zYCrxO3CitFqYU9LJQQC8m9wih0Lo4PjsC7z0FWOX+GO/SmHf
         eJOgiyVOGJnT+CZmkDijolOGOHMYWBEzBJ3UkXMvGu4A5JwW5LIGkH8wDOWrVSQ47cTH
         026XuO05kX/SzNEqMSIMBZlJxvsu1j6SE0bDeeD1ZrvjocgQGHmLIb9auTbfDEb6BGfk
         thJmqRUGRIwc1blGhPWXrSdozxcgbK0LRQw3rxfqxGHfclqWU7q4cTTVaCTG2Yftj7d6
         O/FA==
X-Forwarded-Encrypted: i=1; AJvYcCVYUctN6TQdFgiaUleE2fRZmmGOfLAyPZJwKLEB6q0FfniDPk2Q7nDS6q01ufNwNkJHMiTsjSU+oxf9qWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwwSHmek+vbWGpJ7e9j80pLL+7X1fdYS3KF5/MYeKcEBMpJbyr
	kQHTSPlJsQehBRbVRgxbJHDceD4+tKEqKPw/onyC3hyxxcTMDX0gVxbIOsukWQFVzz43JxS/C/W
	CcxTbeKF9nAE3wTDKRuwFq/0deUfaaSM=
X-Gm-Gg: ASbGncvJzWAV6BKby36bQdLXvsNl3PtEEk8SzobI3RT1bY7UNEsqcOWhdKEcqpwh8KB
	3/Lj8bMl58r7GAxNbLfpMO/ZP/XNonPOytCvbGtdCw7/hrvOK95lcbczFBXZxYZrlmCS/+ctIuR
	HUPwXuVah6v3aMjy3YPm/TskYNG4d7QGyAx6mLx7mortaqKVR1GU+ec39kc0txbvoSimIv/stY6
	CffXFsHZW6as/PWzFrYwwXYFBuDhp/P8Zwslzi7gi0tg2v6oYQVKx3SSkrpdFMFeRsVlaAq0vvp
	JzHCFhyr9vGdmTjb1v8aZSZU9Q==
X-Google-Smtp-Source: AGHT+IFGrG6pq7rWKm6aIR+7hnroTx4r9F7GqJTK8ku7OFj9kVD3jVgk3lYQmQV7GKSfAkPSy4Y9WHViCHJ0OdUDFlY=
X-Received: by 2002:a53:cd86:0:b0:63b:fcf:5c5c with SMTP id
 956f58d0204a3-63ccb817b33mr15696163d50.11.1760441741317; Tue, 14 Oct 2025
 04:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014050609.349461-1-kartikey406@gmail.com> <e6bb05f7-8f05-409f-9d87-2d25f66942a9@redhat.com>
In-Reply-To: <e6bb05f7-8f05-409f-9d87-2d25f66942a9@redhat.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 14 Oct 2025 17:05:29 +0530
X-Gm-Features: AS18NWADgpzWMP4thQRXfhtcU-zx-hQnfX1rVdSDKTbFByCZERsGs3hEMU1Ik6o
Message-ID: <CADhLXY70S17ZSnp0B=HYNgzqP1Ty5AppY_cKUteBoryGkF=y5A@mail.gmail.com>
Subject: Re: [PATCH v6] hugetlbfs: move lock assertions after early returns in huge_pmd_unshare()
To: David Hildenbrand <david@redhat.com>
Cc: muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org, 
	broonie@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi David,

I've sent v8 rebased on mm/mm-stable as you requested. It includes both
the skip code revert and the assertion movement.

Thanks,
Deepanshu

