Return-Path: <linux-kernel+bounces-841893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAFFBB87C3
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 03:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91D5D346147
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 01:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE5A1624D5;
	Sat,  4 Oct 2025 01:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5076c2p"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4385C4A
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759541704; cv=none; b=Z5HbX2T68V3WAt2S9fnSRuLvH5HoQa2boA4zI4Ofx0mFjhJ7dtAV06wJrXyiMb7O5Cp31NwAUHf+NelnadMzBKBrd4gHFLFw56Q5uA5e1nn/ZdjTWKSqXpUPQi6oqoyDgkDcWow6gEohd7120jQm4SVWwQ792hCEBqSpY4b/BQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759541704; c=relaxed/simple;
	bh=/X0V33VDiMRdzcsd9xCnRB+qtbDJsOoCsmyTwGkXd38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IelN0fdoAUO3BER4KmZp13AltEcO/1ZQxWnmb79k5uqP77P2EZUChALXH8rg0KjR6YeJQz48v+5z+/cE249gMrZEweIH35DwKLbjm0RdQxBv9bhpYqQBeN+P0viaWTq7ThSPNKFH80HqiMeAO0J8FEeuZtBpNWNpUTr7tahtMio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5076c2p; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33292adb180so2910227a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 18:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759541703; x=1760146503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGIfLpa2Q+QL0lXCBixwDO1WfArX78dB7nRpjLwydus=;
        b=W5076c2peZjjJnKZLFAVXuTBgDjiSeRNg+98pozIygBrGjql+ZCHrpEFqwUBNwzpZm
         MggUIt8uQ3Mjh2Ed6Eb5bqaKWmMwXnelyQxOPrVdGtC1i2xL0lh7Xc7fBT9T4CuR/RVs
         hJkXFHKzUugLPKaGhYy/FWFtVNXNSqCsJo4q0YKPuk6a6OJGqsbhvgjm92wZbmhsV1eO
         ubNax9CSbwnbMDvWXGCe8fDsrwgo9N4ZrZ9RZAd8rQ9llx+lTOcxG1FIvo1QKATPu5rq
         QqrC52tXA+/rSqFaVTwjCRPLCzsusKs2ey5hjCqwpMl3VP1MiCvUzDk1TXTjStowfpyP
         /zCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759541703; x=1760146503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGIfLpa2Q+QL0lXCBixwDO1WfArX78dB7nRpjLwydus=;
        b=JHOgJkLzi3xZR0/iA6fpruG9DzKHKrGZRwXVoDNnMS/Go1Ecou958iPcuqTyTuf4wA
         3Kr4RA0O6V6nwchzLzeKaxfRr03035KB0pjWtN0zPWvKDnW+pVvzl+7oSFqdhWf1ycGR
         btEfhqYDLPdIgC3460Qjrejwz8PZGEtuesw/+b73gtya0L/+jwYQY1RIzAq+pAY0uaJN
         zMNAI+emaJJ+iuQa5gttXH1bC2wmPVaFM71X0/S6+gkNBCKQbYO7UPNK+GMroD3ggTCN
         iuelRMcgRv8UdVMxH2C8Wn4bWJJ6FbMtAnsD05/pqGzeG2e6/jP4OVzRoqDCmTqcHk1R
         KDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGdKUKhte0pssTDjDutu4hDGGBj/BMsUBjFIAaxT/CqR/rm9xzCcLW52CMkyeuxG8m9IlWhDBMoNUuNT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTy+MEi1nWF6V38xfriEc/OS1FOGShXhgiOWfEgCCHbSs5s8g5
	fijcPpAXN8YIN9HRZqYCxpF9qic4XcrhSH8q5ep2IXQB9ttbX6QGEa3AwudeC+HJ+gg=
X-Gm-Gg: ASbGncs/hGrWQL29SFaXzAkkyC9Od4KGF4O6NzsAY0M7vHvJJPXgE4Yz2S0EDqwrYRm
	hmXPSUK00wOFosY9Pinv42bKelptL4tNqpTF8+Bd2+C41KQZh44+oIjYW2nPv2ooZIj8ZXHHre7
	+mRY7+sbEEcG8DxtABzn1UVgCUxPnAON5lzvg4z5yo7LjnUzFSgFM7qHvt7Pegl31qpvj/YzrjW
	EVMM59ya1qN3ggisJxoMdgxa3TmfvQQmmj6cJogO70bCstyf7d+eFxMX0jgD4tvd519NmXwYXQj
	IDVmX20tyLiketEI0Fa6Y2HQl9mBWPAR7PW/50aViY+6T20cKrm4OExj7mnK7ywOz/mVBHCXbW4
	2vrCcd04o7ysbDQ+GRNgKfXRUKmtioNidAKCUm2dCQgQD1YW3FcPO9g9/s8n1eFKaHgUhWMWAYR
	f9u9sFJSATL5KIKZfKsLrRp+tippHSwAB4mPh4
X-Google-Smtp-Source: AGHT+IEluKCvgWoEGyq4QJ38Wau8hJVOI6ympnHbwypwMOvZncOrazRuT/Kg7dMZuyzHuQxYXNlL2w==
X-Received: by 2002:a17:90b:1c8b:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-339c2707c6bmr6250088a91.8.1759541702729;
        Fri, 03 Oct 2025 18:35:02 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2401:4900:5d47:aa18:a39:a592:bca0:286e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f599a2sm5723647a12.36.2025.10.03.18.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 18:35:02 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] nsfs: handle inode number mismatches gracefully in file handles
Date: Sat,  4 Oct 2025 07:04:52 +0530
Message-ID: <20251004013452.5934-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I wanted to follow up on the v2 patch addressing the nsfs file handle 
validation issue. Jan Kara has provided his Reviewed-by, and Christian 
mentioned plans for future changes with the unified nstree work.

Could you please let me know the status of this patch? Is there anything 
else needed from my side for it to be considered for merging?

Thanks for your time and feedback.

Best regards,
Deepanshu

