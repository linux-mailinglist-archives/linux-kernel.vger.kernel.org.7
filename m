Return-Path: <linux-kernel+bounces-826008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 914EFB8D53E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AEB189F022
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 05:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36962BCF6A;
	Sun, 21 Sep 2025 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Rf4ZLtRn"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC742AF1D
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758431935; cv=none; b=E/ghtEUjwmFBOSVhgBikNvqBLudlfwm9BY7vIJ4LDEP/7eEAh4KWxznLrz1asXaB1Pp2UUq+DhATuI87DgTB9h/igCPwMeAA1ls95IlN1lNHay52tSEZ98VyBFupQoXoxT/tV2Ua84HoQPRX9Fjkx4RSlyzr09xQ+1tbRT1up44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758431935; c=relaxed/simple;
	bh=TjboM2/L0f9nAWei19mZ8FDgalcu/2Q2kDV4Dvf75pU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OImk1CfTEMIGfn5EYB4ZaPsuNV5BHeROksDXJq4LydUbG7GsK/IQNi1BcvEAtePR6rmwa7GT+FlFQJMJBFjPC4Y/Uz3x2c1NsjTYp5EC1TjktiM5nLMNONZKsMCcbfabKeI14ac7pA4DD8tMhH2fZEzKC7l8qf8EHCc0GtA5yBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Rf4ZLtRn; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-4248b079780so5789125ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 22:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758431931; x=1759036731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHhQbTj4kYsvAqUw74p0VJZScNEJAQRLYPDi0Xv2iJk=;
        b=Rf4ZLtRnM/swyZ+onh9AIO39xwimd1PqNKZpqiFBSx0/evRNqadCxPKbxA7FqoT7/e
         KXMA3YJu1O+rlrAZYK6bC3LH9qHqlQgexvPR8SuN8ReGxLtm4My0LX3fC8Q6n3Z7AHaK
         VOA4j6urQvn8hm86BtuezdHi51GF3Lnz4Fh4Tx1ctqB8ORj0LNn35mjTn6tcb/e/Ti8U
         K6tbpBDSpVrjr8u8ghFQRmOqdxcLN72X2B6Ez+CPgoGi2nEpMPTTTjGqPsqOH2jDh2io
         ik8Rdx9jmDYjT+LhA+Zhp45BLjJE3NJD+qJ+UdC86DMz/V5ef8rqFV6ZMVN52/t2fK5J
         YK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758431931; x=1759036731;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHhQbTj4kYsvAqUw74p0VJZScNEJAQRLYPDi0Xv2iJk=;
        b=b6epqdiRDG7OWuZ+Ve2fSfXTEhELaKQt0oirVrt6ndeo4l9LyEkeyElyBq1lwTP/wt
         /CsjWRBCAE7gO0U+7aNspJuWred1OXSq42dVrFMkWYMyQ25teHqtyFHauoIJWL5Jy57q
         M3iLYRZNnJ7UB0oJKq3ANDdJekdMUo7S9K7aGkonZ9UjvG1cMRyaWMqseU9sp8eFqMYA
         elNdPvySOVvsdjCjsp3Ruy66ADqjZdHaP91u7mYlOVMrsOogapi28RG02/L9HyvILoxJ
         qeAAX4VNY1PXCK7S3s8TmzzLq48TWR7+ZEfzBr8G3J/swI4/YZu/agb+2ipruK8c4dBA
         AWPA==
X-Forwarded-Encrypted: i=1; AJvYcCWVU7sIqnk03DDJOtGZAjkPjrewJj5bDUikZgL1cISYd5USteyYKu5BUPs3VBZ9xRThluH1jMevjsQRhPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7mHcbKG6Ixl71q2AtzABOJGgdIjF2aHk5VlJWPwYFuW4sv2aP
	P0qI2Jlx5kx9fwV87hpmtAlbOK4hLRDW/PcJPDMsZtS5i8O3Y6gYn+p9gpvM4kPrqcE=
X-Gm-Gg: ASbGncv2bBHLg4ZZvx5uVnmEVygneo3RM/DrJP/fVcLYtAP4CWwQG14sxblrFAGwePU
	tQ2v+U9n6DhYhJnR4UJNXdDJJ25llCInuGCCoI2OWyki5+X+9J8y33W6BKYq1CxiwYfS8C+65Xl
	S9xdg5yAYzKaLyLbsP8/PvxIKbpf8SSBVy6R69je+NZNgm/9Ej9FPegqfskettM40CfVAIvMW3f
	Su49BGrzvyfh+qsTKqd09Ze50YkSvJn59ShVtsWG3hI/QpGUlEXe9q9ouNSQZ/2shcpFAj+/WOF
	nx0FDW3kCUrE/lIqM1ZM4B4T7rP8oakRzg/h0yRqiN5bSYKiF5bOgt3qJOXO
X-Google-Smtp-Source: AGHT+IGjpV4kJ4Qy0bZ3vJ4qp7i08XpmUB+fTdg2aDRru5IriHCuc6P8XxrDuu6gS89i52MJD4LExQ==
X-Received: by 2002:a05:6e02:148c:b0:424:80c5:87a with SMTP id e9e14a558f8ab-42481984015mr120728015ab.19.1758431931221;
        Sat, 20 Sep 2025 22:18:51 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.128.67])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d50aa5db9sm4228746173.43.2025.09.20.22.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 22:18:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Mohit Gupta <mgupta@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250916-ublk_fio-v2-1-04852e6bf42a@purestorage.com>
References: <20250916-ublk_fio-v2-1-04852e6bf42a@purestorage.com>
Subject: Re: [PATCH v2] selftests: ublk: fix behavior when fio is not
 installed
Message-Id: <175843192257.42245.2136343963364128168.b4-ty@kernel.dk>
Date: Sat, 20 Sep 2025 23:18:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 16 Sep 2025 18:42:52 -0600, Uday Shankar wrote:
> Some ublk selftests have strange behavior when fio is not installed.
> While most tests behave correctly (run if they don't need fio, or skip
> if they need fio), the following tests have different behavior:
> 
> - test_null_01, test_null_02, test_generic_01, test_generic_02, and
>   test_generic_12 try to run fio without checking if it exists first,
>   and fail on any failure of the fio command (including "fio command
>   not found"). So these tests fail when they should skip.
> - test_stress_05 runs fio without checking if it exists first, but
>   doesn't fail on fio command failure. This test passes, but that pass
>   is misleading as the test doesn't do anything useful without fio
>   installed. So this test passes when it should skip.
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: fix behavior when fio is not installed
      commit: a3835a44107fcbf05f183b5e8b60a8e4605b15ea

Best regards,
-- 
Jens Axboe




