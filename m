Return-Path: <linux-kernel+bounces-831922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C03ADB9DE49
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF621B257AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBCD246766;
	Thu, 25 Sep 2025 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG3KMu8/"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE766FC5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786394; cv=none; b=rQvI9rN5tmwb5EYp8G8eFAK16Jbt7isjaajoagy5xoJfesrw10f/auvbJQ9yjt/np9Dej8R6NA4XdqU4XhSo1PQ0CMEPVJrx/z4YaHm+pxa+33ynbXU8CxKtKm9fAyjfhaTAJQChAUotTmK2cD/j4eOoQGhbmbSFJ5BV+GiXITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786394; c=relaxed/simple;
	bh=jtdhp8/eWxBbnFoUTD5zhB3JSfjAFt5l4grv877/WGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1bHNvp0kZxburaqpSG7bzAeLER/u4zh38v+oHP9a3+u28H2u9/+ofk6jeE1CEQFlMILFoQLzCjE31QK7phe/WrT3mMJCaASuE+A+gdLczz2OH9Z6DLcLO99cCkPdCUrB3urOVSZmH6K/qV3fJiQhM3GDhpKFDqRYrdQxgO4LkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WG3KMu8/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33255011eafso651569a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758786392; x=1759391192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtdhp8/eWxBbnFoUTD5zhB3JSfjAFt5l4grv877/WGA=;
        b=WG3KMu8/2qZJShFG8hz9XrX7A9NvJmEplDYvLmhF361coxYx3d6gGMXdnUz4CLW967
         FnSH5KC7F3rh21QF8fqPHU9ikQUafZGEKCsqCCqNIOBDjuVp9aPeTmvzXbooH9OyrCpp
         27KbO/YdG6ZdWtYUfxYdZGe69ae+kymxk0OH64ef+YiFlXJFRjHy6KucAUSMo0m3Q8xP
         XBzhR+S6b4k3JMvf3gDAX5SZ9MqyeiR8GPZRDRLPo3AGPYYrSPC8gNv5uZOg4/9Rl8YP
         FDrO5yW+9NR1t+3gv/B0X5kII7asKWaaa0asRrzgYJgHq2ezJql1ZjNCXGW/h8OQK+U3
         TDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758786392; x=1759391192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtdhp8/eWxBbnFoUTD5zhB3JSfjAFt5l4grv877/WGA=;
        b=MUaDayYlhSRn980Y/MbfBo/fYRUkhNFBaJQXtBycuBLoEhbwVd25w0Z6dk+IcweMhR
         BlSRqkfsM4GYqXu11ec7Y3VUvm827GD+CKvtxpOPBW6+FJLsBjM8tS9UdS3vv5sJPjlY
         KrnNEYphfeGZOoHVeG5l2m1pQxPsmYIYMCAwitTibO61eAmNupujtTip+xVPz9N0yTQo
         WsjNMPRsltiH+vGPv99sfLKNIT1dOk4Y07CCa+Ey0u1ETR4dH8QML6TYwXIRAORmXUaJ
         UrWvWpb9nz1nbsXCKj6om+4IL5VItvx+6LwRK0KqPv9iy/iG0trkg2WqBblB7iZCIdM6
         oj7w==
X-Gm-Message-State: AOJu0YxbIwNsw8bYsL3BlMt00In2NvDItzw/8Ta4WZdq7jqrgy+ScI62
	d4Nya9qh7DEyXMHVHkzArUIH1h71WllTPcT+jxmJ/QTc28DSX2cDvhXq
X-Gm-Gg: ASbGncunIBpNHuWxoePz0rtHbSumrZ4HQRuiekDSi/YkB1BHvRb4B8YkWI2Dn0syyCU
	a5SfCmR9tkUAFQg7pPbo/dAaHBuXUBKJ3ijNuZHBXOAGtGNNQHWKy7/dbp4o9sQ4yyQh4ZhGBol
	mL+m1hbMKc3QGpVuLtcY86IPXE3YhhkR+r00sL4Bae8NS9SxSbyufsfKjrFETSnQkn7xfqpehdg
	kpbwetyiZ4Hn6L+Lj/WXbv5VaVBtlhmvkiMDMb1TZW3LBtUfefx+x2eh8dWB519r+5F7UOVGKIj
	1x0cXaX8P+nZKetqxKLIaQWY8HEw+o+iG6HAx/E9Mz5P8fPcAcv+YjrgPcby5fsG3zBvkuB6HbW
	ReAdj2yz0240kqsSSHoQGFPpZ
X-Google-Smtp-Source: AGHT+IEgqMY9KuuP+oAMZMqc6Jdkr6xcn2BVicCSHUX4Ny0/XFHAn/j/jN3MLmWXNnOeMrfb2SGggg==
X-Received: by 2002:a17:90b:1808:b0:32d:4187:7bc8 with SMTP id 98e67ed59e1d1-3342a2b11acmr2858725a91.27.1758786391907;
        Thu, 25 Sep 2025 00:46:31 -0700 (PDT)
Received: from archlinux ([36.255.84.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be14666sm4753864a91.15.2025.09.25.00.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:46:31 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	madhurkumar004@gmail.com,
	shuah@kernel.org
Subject: Re: [PATCH 1/2] selftests/acct: add cleanup for leftover process_log binary
Date: Thu, 25 Sep 2025 13:16:23 +0530
Message-ID: <20250925074623.142164-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <d8df684e-0c09-44ea-87a4-cdbaf65ab0b8@linuxfoundation.org>
References: <d8df684e-0c09-44ea-87a4-cdbaf65ab0b8@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Madhur Kumar <madhurkumar004@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH 1/2] selftests/acct: add cleanup for leftover process_log binary
In-Reply-To: <d8df684e-0c09-44ea-87a4-cdbaf65ab0b8@linuxfoundation.org>

Hi Shuah,

Addition and deletion of the line happens due to
the newline at the end of file.
Code unchanged otherwise.

Regards,
Madhur Kumar

