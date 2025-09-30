Return-Path: <linux-kernel+bounces-837372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CBCBAC2A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45B83AA3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA242F39B0;
	Tue, 30 Sep 2025 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfkIcLaJ"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C085244665
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222966; cv=none; b=YpHFDr3RWPjU76mxwfUjXCtGwmQ+ruXEXzXcN8tLOAQ4lvznVPU1XjbN8HrJLFnMGpalofGdqPMNPfQLwyUbCnvv9rhuaSasw0gDzkxWKBn33RCuZukOioqKKhnptf0omWXH32Pp4X6gok4xhm7FJpnbCH2Nm7cOJK8HVqCZSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222966; c=relaxed/simple;
	bh=xH8i/P0F5GMyOhXG67E/jf3pgWVIjy5A0p9ko23ALdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUBg/vMVLRkA3v79jNsr1t4VVn+IvIRIkjN1ALDnDLyqRtkey9YAYgFs+VULpTEQ1BJ3i7YxKbkKv8EIio3qOO49ZsErvWNNSqZFrRAm4ya63lt/LZ8KCH54KLTkFu/Nig0WzNTp2A7rJeV2dflCAzatBkm9QooxQMVU2YyO+Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfkIcLaJ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5d80f5a23eso414362a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759222964; x=1759827764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RfeaF9FswrT4NLe5djmQ12Uk2hNy67gmHZ8YeclLXV4=;
        b=TfkIcLaJyg0h5hJXbCTodrNbQa6oTCT/HTtwDu7kR16jxHEIApbWX823s3by9AvqzZ
         tzD/cti6th2V5Y+wQ3uznjPlMN6eFpxHFUu+hZmkw/fTfM0bAA7YqWkFwmWfkQqAs8vu
         URkveoEMAXiT8Wil6hSQUaUB1EyVXODAPTtxinwGAz1ZbJvTjygyybz6craNM1LTv+L0
         sy6s082ByoIYe+kBW7YJmq2GS/j5N1wRqwwCPgYI6gnUUiNMjD1Kwhs0XfdfX9pY2rAi
         LKgOt3AwtPwuKMaBq5GpLZi/BS8DgFFahh14CpdDlwa6wBKIMJCQuHhgdFnU5tQaum7t
         9ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222964; x=1759827764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfeaF9FswrT4NLe5djmQ12Uk2hNy67gmHZ8YeclLXV4=;
        b=oYX6r2qQr87cXW+FgXi7Bw3/2pa4uNOPQCZkxDYYrhhHXpYM4QOJuXGV4i8MOkDxIO
         1UpENUD71YGJ0lA83xEuSnOx94RptX6OqVZ98n0iFggBUpyRkjDeY9R27xP2uLiR0XTL
         eYl4lBf8663bMqgK2I3byPxfunYWUmd6+eexzqT5LPlvvsD4nUwHuhrm5GDPaiwjxTVt
         BtH15ddIK9FmI82xyC34j1ndPjesBlDxXjNskdv9ENvyAOFKRRlAUfwT21Z85dEortTI
         gRJaeYrTmTvy7F5oPIQtewMc20D6+PIAD1zVaSWXtfYBP69Nxb5uRMGumFmFdgFcPCYs
         vQUA==
X-Forwarded-Encrypted: i=1; AJvYcCUjbQ69LZHz5ZsGFAedcREwKObXRh9AisN58rckoti3zTBB7JsO/JR9VH6mpYK3DK3Y6/kMi80o6bUFjUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyndB8WkwxsdvXbN/mp/cO7DR272YNuTYKZOyld/xugzwo5n9pX
	BgW7tOq01GkJh6MrAgofbZ7JREZyBGOA7aBeBSVg0RABFSsKAGIUWMc4+G1Wc/7KXUA=
X-Gm-Gg: ASbGnctn4RUfribsF0miwSWeskzWIO+EGWjeXGzeR1gPPe2+L810jfNu+3F/V1NoEpE
	Buf0XLAQtaVkMjyrfl1HpDAaVkR3mKwX6fm8RbQ3nHIQKSc363pq++Wbqvmx7SxBelU7sVrfITc
	b9naCBqSh+FGEOGQasJI34sg9VsZPyzom/XO1WEMImg/H+5erOboeVNeSaKT5qi6sOKGvW10/DG
	U+cjjDYZsWWVUyB/h/fPd+Sf2Ia/UqcR6rH/bT6UdVRnrPj1gHBFNj20FzVtxZrJ2vyq+4xjsgp
	sT0zTeXbKO0WZ5dKMgS3eMeXU7Gf0WdPfoNgflGHnF35Zzgny+PNc4/rIwvXBzfRfz/7E+GTRsL
	/AIYnGrs8BZL9lwBa1LH/MGGo0DAdoePG+ByJ0V0cIQ8oBqGR5nSM/ZhaCWjs3OZTtJ07mZWPCp
	iCpZmN0ANhf+05szjxtPdWZ5QvLkY=
X-Google-Smtp-Source: AGHT+IFd5eZhiu9Zd++0fFXkMaMCe1sb8fKeTrMPHQa68TU2FlUs5KWRM1gnHv548WvGqki6zxCoZA==
X-Received: by 2002:a17:903:19cc:b0:279:373b:407f with SMTP id d9443c01a7336-28d16d72a20mr45272355ad.5.1759222964145;
        Tue, 30 Sep 2025 02:02:44 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:a158:2d96:7596:9c93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3acfsm154851715ad.20.2025.09.30.02.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:02:43 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
Date: Tue, 30 Sep 2025 14:32:37 +0530
Message-ID: <20250930090237.306607-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zhang Yi,

Thank you for the review. Regarding the placement after ext4_set_inode_flags() - 
this would be too early. My debug shows that i_inline_off changes during inode 
initialization:

    After ext4_set_inode_flags(): flag=1, i_inline_off=0, has_inline=0
    Before my patch validation check: flag=1, i_inline_off=164, has_inline=1

At the earlier point, ext4_has_inline_data() returns false, so we wouldn't catch 
the corruption. The check needs to be after all inode fields are initialized.

I'll fix the alignment and use function/line variables as you suggested, but keep 
the check after "ret = 0;" where all inode fields are populated.

I'll send v3 with these fixes shortly.

Best regards,
Deepanshu

