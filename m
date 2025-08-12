Return-Path: <linux-kernel+bounces-765609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B738CB23AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A25B6E04D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55442D062D;
	Tue, 12 Aug 2025 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yXaZO/Uo"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC20326E15D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034304; cv=none; b=UiLHuplyVVuPgEcqm+4xANIRq6/d3daRxPB0BikxoNmw3akG9npeiKDtFg4c/fi+J3NBG5VuebwAF7ORBdjR4oMQ3Ew+nG+bnsnjZke1YvmQYAf4ZT/2cSD1D0lYLWc4YrFSd9WlQdVm5IRoRuMw5G8sh3rnkgqwtK9N/IkA3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034304; c=relaxed/simple;
	bh=enFAnsuBI7tzmg+XmneTDUq3ne1AMj8+s7skBIKgsMQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M+6uk+9cWdvTavmhb5QqekND31Ra4TIUBpsHsjZ0uCTEP61EB8NMkrslWRw8cdGGwQOiCBA56RX/4LjyxfiOmQyyLvDOKddXQhbbwt4dKdNf3BrlCO7M1TtkMzdJ50wi0Z4oV4WTDrXj2xGxXjjfPEhsIW1aD6Um4wFZG6yClP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yXaZO/Uo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b42ebea2f2aso2586918a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755034302; x=1755639102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmQ7nvxSibxmUYTy/1bFPxOn10Uk+OIUVnbImlldc88=;
        b=yXaZO/UoET62Iuf2ZYzjcUnivma017SEysZaunvi5McG1tjlYtOxTS02Wxxq1CRwGD
         PBaj/qNcARKX1of6jzxeUg00paxv5wVTCIGaMOfeha6PTtQt92flHKXqJIorMZKD8o24
         7d2PAb+LYqyxLFX4Va4HmCSHAfoD8NC1kt5K20z/h4cfVTGMscMTbh1q6vfngSk+Td+L
         G4b3FtWX7rZeoRfv27TFq70djLxkHOLEuBIKR9ydlbafBeQOoTST5M9oZxWlhU4eZaAS
         EXg+LC1lUtWKTiVPp+ADDDStBcTqtqOCoFpo/lL5t51x16+7lOPPy9SAs215ICRWFQ9t
         aQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755034302; x=1755639102;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LmQ7nvxSibxmUYTy/1bFPxOn10Uk+OIUVnbImlldc88=;
        b=gEK+oBLrYBJVRp5xR9DA4RLoTIgUGe+/PKFfuylD8rKCR65CEQgT5sbqPNwV+I2k4y
         Zslnm2US12Dgdcz4ziE9JY0xA80/1KWBrPO6N/k8uhsJQvYtrXd1ipC5/EUMMkqexwtc
         lPjVGFOliR8820jubNXeqtLz4jn3mk+y+Wwsni7lm3/+p1CPrtMB6PKNVA/xHGsiqqNV
         Wyalny18BZ8+sy/oBi0sDMaqfyw9J7LoMl9SVG75MriV7wyli+hgfsxzZb1dekVa8nKp
         S3eURLOBexnGzU8pRfv2AC46DFg/ZU6rvR8ULjLuOdOXBBt7yU/9fCBU1MiNv8lmcgdM
         4q0A==
X-Forwarded-Encrypted: i=1; AJvYcCUqvVFBxnac9c/iq6Zc1UOhnAq4s5kU/Cw5vEdWHYYXpJlqEnp/KoZzOMCqwOhZKyNajF5XO+lHr5JixM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9MB+8kxyG0pJQdZXHhdkcYCH3FuUmUmAItHiesVV1hNKEOlYK
	w1i7DSMbA+hc5/csXTNDvbLAnHuHkeifloXTha5UEd6oP4z5uqs7sjdkt/RWbdhuxVDyqcxIW+f
	ZybSpeQ==
X-Google-Smtp-Source: AGHT+IHViKr/WTmLaVxvva9jhkIu5PG322nOf87K7N2XTyh0J1XIA4uCdArN8R4zYi5HUXl83HRkSTciuUM=
X-Received: from pghm11.prod.google.com ([2002:a63:f60b:0:b0:b42:2386:7609])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78c:b0:235:6aa:1675
 with SMTP id d9443c01a7336-2430d23f276mr9439865ad.52.1755034302080; Tue, 12
 Aug 2025 14:31:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 12 Aug 2025 14:31:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812213133.161300-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2025.08.13 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

PUCK is canceled for tomorrow as I won't be able to join.  My apologies for the
late notice.

