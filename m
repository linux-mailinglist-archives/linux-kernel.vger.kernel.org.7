Return-Path: <linux-kernel+bounces-895691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37995C4EB7D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CB33BC4EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C213370FE;
	Tue, 11 Nov 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FQKCeDhv"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C2925C818
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873149; cv=none; b=ruJoVZ+5AvncdSVi939qyN/iw0yhr+Zy5usccGdkszKnylkT/K7y0DIjeyVUydFp3huw11lP1g7k7qCcVCja8oe0gTR9juNDqrwdUl4OaAP+ZT7V32dzzIaOSnK63BvvLcda/0hIgK50Fw/jDY94jiKl0RRr3m7P96eT3m1wKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873149; c=relaxed/simple;
	bh=p4NcimrN2RPYbrdDS0aQ7vYMlnE7U1wMAL5BiS8FvCE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A/EPvjdMHnzlmNOE9j6qjvymiajzr8YDZ6he4G2UhDfPAn+QfEbRdJgr/Tc3PIN8uyKmgGNw/DQ+a5KdPtLwh55nZH9XX4bMx5MpL/76dTu7iocmb05tIrBJ7liGu08sFuBisSXpgrmxs3lZ20LBwAHBZXonyTsPrlm1jxHR9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FQKCeDhv; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-431d65ad973so17685595ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762873147; x=1763477947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2l3/DAp/XMYRh6GYe6vQu+pHtDQHTp+dBAwA2D1Xpw=;
        b=FQKCeDhvNvp/aOjvtyPPiZSNzKMfF30ZHN70BdPZeR74DfMy27oLQb+apE+GG+FQsp
         /BwyVc3BNVvXW9acCYJlaoB8MuEPhtnRpgRJC7+M1V3axKTXSi2/KigO4DrDtqe431x9
         KNUPqzKpmRgUlIeBcCwpHgvemNZQCnp4iQWX3nCeeQfhIwaG7jRru2DbjDyuicvNZKvh
         AgeRaoSepUuPjAvk5KnGi6n87ePwozCxGNp2VTa4C5uYXGyd5YA64kmMxrJfPW89ftQ7
         KjWUg3ICt1VGldjDaJcgIIG2Tb2Y2RAd08+PW8eTg+eRS4YEe89R3yHCzx4Snzus6uPw
         zT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873147; x=1763477947;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2l3/DAp/XMYRh6GYe6vQu+pHtDQHTp+dBAwA2D1Xpw=;
        b=Ro0vihJyXOtvKfkSyyIL7fcPuLpkNxk8smBgX8q4vzGceB4+ReTYbe9sq8csDqLn+Z
         40sIgCYtByWuJvoy9swYnpIqRsJtbazdeNZVnYuVKt3mJ7ZVB9WnuiWr3KfcguVam8hr
         8og35EZGtMakaKR3lCvugqiYCxAuJ9Sm6g1cexn5+QKiDPGq7kUN5kEmYk+6khp+yY9i
         nVgvVg2CDY8rkmTk6g3/z2/kT9UJIkf7bKd55rW2GSl6DHjVRwyjOeXwYXql5zGCrM6J
         xKYkggL3JmmWW3C+69ebEyK/D5Q0HJDLQIEyG82Cjwc2x2qJWp2igZgDWC5xhuTNHQir
         L/xA==
X-Forwarded-Encrypted: i=1; AJvYcCUblnSB/6uMOPXJS9Yj1TFeD67i4D8/PeNBshuth7/El7T959K+Wn6KyxKLhLvdeVl0DZphC7PmRLo1hvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS2wDWDAyHSqcu12KW8oFpIKzWnxRDAueShSoaqRuwJwm6FJJA
	js4p2wZWZQdAHBv3RlrylDdU0GOOhpwPoTFO2S9zYko4Q7rdU783G3+r5vwAbUBSKglPw6eD5+f
	cs2Gy
X-Gm-Gg: ASbGncsCJoQ8XkvYJFD3UgzVKgEbuLbX1fFR3iwdOtKx/W+DoAql2Ylxk+6Yg0OXq07
	BZ0H8IzwDNVY231DfZNHDDZ8vTwU2esVgoBfNTj2lYzJjR7XIfOOcX1OEirgevBQFBkSMBYjCfV
	0Lw/71RHcTmWbhQr2RhGEWxDhU7HN3Z84QBaEk6qSXnYU2UZ10XaQaJDiMDvsjbU2Vd1IVYKg+i
	yYJVgxX8H2haRu+0qDKne3iGXBqfoKVpa+aAMYlzueY2v/j0GrDFemBkRvLshGtMjb8d2x9nZGX
	iqtUrkd5SquNgGyyvWWjya/RFfgQzHJfDZMTwM6T7ywPiVptdO1UPH0cvsgo8edtz0kkqnvdnm+
	t3NwHWb8aRy7BZa43uZupbmZv7klzoaZC3tTvi++P7DlCquAlrRvnhgt44AziVkYE5jijLtGJEs
	J7oB+g8PVqqFqSTw==
X-Google-Smtp-Source: AGHT+IEmsNNjF5MhN82jjicIsOrc06hjWbFtIqHWBtmHjw3+ohFeEHE0nup7E1CkIcuK8C0lO9WCEA==
X-Received: by 2002:a05:6e02:1c23:b0:433:2fa2:a55d with SMTP id e9e14a558f8ab-43367de53edmr206093235ab.12.1762873146782;
        Tue, 11 Nov 2025 06:59:06 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b74695d420sm6036612173.46.2025.11.11.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:59:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251108221746.4159333-1-csander@purestorage.com>
References: <20251108221746.4159333-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: remove unnecessary checks in
 ublk_check_and_get_req()
Message-Id: <176287314577.174455.6127833224197613328.b4-ty@kernel.dk>
Date: Tue, 11 Nov 2025 07:59:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 08 Nov 2025 15:17:45 -0700, Caleb Sander Mateos wrote:
> ub = iocb->ki_filp->private_data cannot be NULL, as it's set in
> ublk_ch_open() before it returns succesfully. req->mq_hctx cannot be
> NULL as any inflight ublk request must belong to some queue. And
> req->mq_hctx->driver_data cannot be NULL as it's set to the ublk_queue
> pointer in ublk_init_hctx(). So drop the unnecessary checks.
> 
> 
> [...]

Applied, thanks!

[1/1] ublk: remove unnecessary checks in ublk_check_and_get_req()
      commit: 6b0a29933f688a284e8869da0f63a93acf893757

Best regards,
-- 
Jens Axboe




