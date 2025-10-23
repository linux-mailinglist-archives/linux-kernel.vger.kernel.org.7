Return-Path: <linux-kernel+bounces-867485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F165C02C33
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364A21AA556D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C281334B43E;
	Thu, 23 Oct 2025 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQvTCQ2p"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DC534B406
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241094; cv=none; b=F2iB+AsrKBZKO51T1LOs0mSwEUhfxORtXY2W4O/xnTAEvyNUamG5K5OTFEIxQOAkGRN1r8n95Zt4dFBiECpG5BhMOpTR7k07un6UCKuCB7woFz+qhx6UC2iPfRaf/s4TylLdXYX7HDUC038oT0d1j180xUo+vtmCXRI8E8loSYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241094; c=relaxed/simple;
	bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdusQRkgcKytzY6374jsM1U8ayQqgu4l3nsWW2WPuhokvi7PnyHjqBntPmZ3sfO+Hz5T3RFr38YNHm5WatQajhnFaKHrp/Hvq1TQdxJUg9KBpR9CfjvotD1LJLH9C2sTrNKCxB0Sq41vHHzO7ia8ZAKhi6J52Jxdw4ufVHhqtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQvTCQ2p; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26816246a0aso1428735ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761241092; x=1761845892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
        b=WQvTCQ2poQ0X9GhbZuZkC9Z4n1R0iEJDBtYFiyVZ3meO8N9uKX1HVXbvcP+9/b0DxG
         6iVcPY/brnKMN2r+VNHegV0SY4w/c6ERr5yDJq5z+SqusZUrRo/tJHIIHDADWh31qVxv
         BaezDXoL7fp30b8l+GXtAzWTsh7vo1rzve9hxJlJX+75aCa3w+8N6aBdQMg11AzaNurQ
         Ouk8ClgLzowIVgGb0ENVkbExGBkmKndvmmOBVhb0W75Haavx/RGKlx3b1ZAB9jxlXMoE
         d/70SFMOrYugIjnaWAsHqMQO5hlAF+TWX4CkFofAPO6rujT3LcUFI2vwJmMSK3Q7xMwM
         lmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761241092; x=1761845892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
        b=UhbcXifxRV9GEAM+hICp52pzx1+3Y0CIDc02kVQQVfvU41PW/b47uA4lg3rZLTAhoB
         RMt8IL8PSqo5vq15ZFUf4/0rmJI70KAmk6vqokUdQ9IU2ksFEXyXPrKAgEmN7hvhRMS6
         AIPlymKAyXB7PsPYg/K3WwGOiLQQRItkJH5Fy7SztFtnyTR68uZgVvNNqJo6vM5qSYwM
         neHgH7HH1S9FnTpyfgYG+OiA7aRE3c2mYKa3glJ6W92txlTB9kMKpngTAw2G09LJBCJj
         bZz0PQHbwVwaEsGIhm4rDz2u1Xs9KRk2A4Qz5E6lHKoPs4eibI/Fa059HxwQXtA15bTN
         cWGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmnJfYN+VjQoLAXyLJlfT7eMiihJ7C7z7t3Z71IzkpbqLFV3wOteywPJdAqtMuwT+G/U5MjdNOVE58WRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfxeiPEpqsaA5XlFEAGPxqoMrytz1csVEFw8LT/sBg0HyKQ9ao
	H1oL4QwyYwfQTAcB3tHDlpXL/kHUNHxPCruYAQi/IWS2FT1nGBTPrrc8
X-Gm-Gg: ASbGncshXCtwBMBSSwvGp38m/JccrllFMO5aGdDGEaNDJYGG+oYH8Vbe5I0UgBjMxrM
	Dibtyev3dFpv1mtHuwf6oEl+GKMq7QlPaeW1vAiq2yfN1pxCz72P+uxHMVrkqbmkvhdWdF6tPhK
	47Z50InkEaGFWZ2zq809ic8A7bsfUU0WIWu3A9sx1+f3OLT6utRRMKe4eInvEZrr9+ssmECgeoh
	x6Afk9bmRi3Y3QYR3+qgoi9xmrQ5HDDVdnGtuRbJQuVfF4tpspaj1crq/jum+fDSz4Q40/UXXoF
	nAt+HqBdW/jYJE8T0/iDQ1Xv8qEBzCTp2tCFoB13b+gWhe/823Ba0TQHWiajGCu5Xjav+ClvYLF
	nfUiWTR1FI7EQumH0kAgzghtN6HYvPSEB9dYQQZij1rUIPneTbpyfsozEugGE6YO3JNyUutKpHm
	KX6w7jQLmy72SrZv8d3+4LFeDGfxLq7Y5YjpDuk1rINAQL8rQ8iYn3Wd0aGYBtQXg=
X-Google-Smtp-Source: AGHT+IHS0h+JRFSFpKN3ABn8gJENaNAJSEiO+0aN8t2XO48O5XiQnQC/G+gPhMwXVqJDR85nhMuBag==
X-Received: by 2002:a17:903:2a8d:b0:27e:eee6:6df2 with SMTP id d9443c01a7336-292d3fb7f47mr76907185ad.7.1761241091900;
        Thu, 23 Oct 2025 10:38:11 -0700 (PDT)
Received: from ranganath.. ([2401:4900:c919:de72:5515:28c0:ad28:8093])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddea29csm29417515ad.30.2025.10.23.10.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:38:11 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: lucien.xin@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	vnranganath.20@gmail.com
Subject: Re: [PATCH] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
Date: Thu, 23 Oct 2025 23:08:01 +0530
Message-ID: <20251023173801.11428-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADvbK_c2zqQ76kzPmTovWqpRdN2ad7duHsCs9fW9oVNCLdd-Xw@mail.gmail.com>
References: <CADvbK_c2zqQ76kzPmTovWqpRdN2ad7duHsCs9fW9oVNCLdd-Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xin,

Thank you for the feedback and response to the patch.
I would like to know that above analysis is valid or not.
And do you want me to test this suggestion with the syzbot?

regards,
Ranganath

