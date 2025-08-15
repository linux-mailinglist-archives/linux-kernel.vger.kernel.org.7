Return-Path: <linux-kernel+bounces-771253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFABEB284BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C0A17C653
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B51304BD4;
	Fri, 15 Aug 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="LSXvTUJi"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC2F304BB4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277870; cv=none; b=N8wHFNcAJwKWvTB0M9N6sQUxoSPHrsVW4eBUJeVQISr+HbqTVjRRM+cH0aFLddvN2jd5GnE9aRTI+JQMDuAB80f9Jt2jjSWJqG1Xenw5/oJaMezkXBROPQmifm7mh8v4VL/7BQUhOV+teJsOsBo3UqmweiJi0cVpl2omD7kM+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277870; c=relaxed/simple;
	bh=4HZvWAZF07QdILcKFutV17g/5NFytQp/MNr45fSPPwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b7jL/xIPcaZtMqrAy+CHbRmuKJ8pZZ4eW42PV6ooEaA04XAdvlcbfmN2uVCOs4IZU1zggNzAWDIKFbJTUmCNk262SUhV89fnzlHtXUUZ++pgdAgXi7Vn5NgalatsPGeycLRJdyc/hU/6q3dtB95yLhMn6ajmiZDYCEfTgZhS55s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=LSXvTUJi; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e8704b7a3dso248342385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755277866; x=1755882666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2O89Zv9S18NKrgTrkfOWonDcQRK/xVnFV6RgQGjH5w=;
        b=LSXvTUJih8oI/e/FUv12Ro4gfFCL/ie11mAEY/P37H0fVuqO/djQehS+GAGOUquPPt
         DULqPILJIpa+zZ3iYev9aUD8jSVijJxtmXufo64pTjzjFiFAXhdk5I3fu3xy5KYMN8NS
         1H1eovrWabB7OCvzsCcWBNF8pMpxpzQOuCtguu3cwLAPFYuw0dEmta3o5i7QujEnSMT3
         FVZU9tZKEINe+F3Oan/6xRW6YBUWlFy60ntB4dl2nnXoFLAA1AWG94GJBerUG0XyHGch
         aTfPwn5HJsvBhlCPnHGHI/faYgr3SQbMjaMx0zXclg/4K3Fn6Ccx3fWXdafGXHS2Ug3q
         TBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755277866; x=1755882666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2O89Zv9S18NKrgTrkfOWonDcQRK/xVnFV6RgQGjH5w=;
        b=aTgz8ykStua1e36Tm+sM27cbMXMwvMot83Uj67/MGdNI8cd9U6P5I+a564E+NICdd4
         xFNaoEPFevOanGfrTmRH1jgFyVUh4kboXc8/GO3srP3FrTOLwfQ8gTeUdsH11ngNdkY8
         Jz2oQ6O31ZmN1X94+tBtCH1uXWkhODr4uc7A3qXMSSkVycyqpB//kk838bVqcjPSOpG7
         uEO+5bKdo0+9RRRPEtz1dCt6yEbK7yNN3jy8kq/KNfT1b4lCkGmytVNicV+iq0P1/Gaq
         +qz40UqiSLE/RQG4Ofme+q+hb4YNMS4a1wukkpnF0HrXk4vNMReKcit5oeJwuSeMm/Jw
         EBmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwuoZuKN4p4GhMYMO0HwCYDgqsJJW2LPpmWUFTK08/BeBXIugSiGJTSfYnJrVsIgm5f/f5QxUza1mkU8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgXrAh3p2xPFfUcJlSP8zoh2x3HYSY0frmhmXmjh4T4dOcmFfB
	UEmRw6rMkTQga87p4EdU8lUhtEB4tIgOxqkZ+Bth+8gW24C2TtkrGusTQn9j0fn/Q80=
X-Gm-Gg: ASbGncvwLtNg3Bp72r8k6DpU5ae64CkGUDbHWbbZO7d9IBXiuwg43m5qIY+DEKc66Dk
	BrEUWVQiI03IHB8jdfiwKEzxywBxKkip6QUH1GyWyE76rGjKygBAODHlAaJ0Y7BRGP/3BgbTRF5
	mi8ggEcC+kwADhxZOb9ZNkCdmK283J/uhSU6M4DGvp7Knazm08+ub/JCKM5PKAekMgMRbBl/qq7
	izsJKhgZfFyEM6IbccNkXKtQA3yxR9oSJ07aTFbEOPBusLhGt4Y25b19KSOMXIhiMvJjKk9tDsp
	8/RujNB4yedOTh0xr+WtdzTqzVg/wUNPsh3LSdNVqsRQvbCcZCbQ9JXGMg3gmJ+145FCWcZK+T+
	x8HxezdRgg+p9aDDg8KE9amhblQhhJcejjo6EIg==
X-Google-Smtp-Source: AGHT+IE1qwoo21Lj7SAsZna8oIYdgZg/fuhK6Zw4I5IO8vhRUjpgFxAFqTwYNfEozZCGITzVt4qWlg==
X-Received: by 2002:a05:620a:f12:b0:7e8:5ac9:7d53 with SMTP id af79cd13be357-7e87e07d13dmr314529285a.43.1755277865505;
        Fri, 15 Aug 2025 10:11:05 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e192d8esm137659985a.41.2025.08.15.10.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:11:05 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Fri, 15 Aug 2025 13:10:55 -0400
Message-Id: <20250815171056.103751-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading / writing to the exfat volume label from the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls

Ethan Ferguson (1):
  exfat: Add support for FS_IOC_{GET,SET}FSLABEL

 fs/exfat/exfat_fs.h  |  2 +
 fs/exfat/exfat_raw.h |  6 +++
 fs/exfat/file.c      | 56 +++++++++++++++++++++++++
 fs/exfat/super.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)

base-commit: 37816488247ddddbc3de113c78c83572274b1e2e
-- 
2.34.1


