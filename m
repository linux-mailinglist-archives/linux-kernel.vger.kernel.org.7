Return-Path: <linux-kernel+bounces-840776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A289BB5576
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4879B4862FA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9912D060C;
	Thu,  2 Oct 2025 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXrHVqtp"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F048E2C3244
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438467; cv=none; b=mXxl/jsDvUdUXDB6Qwp5G0nUXnr7WSu6MBfdpf8RjgueIlS3Dx6WzygX/f6nsaqQm+qSiGLhjpbXsZbY7B7BAA9iR9fIB76eB05s8CYTKJ9ExyZ1o1gT7a8Bn+8c5JcI9PyzY9dBDM15mBEzGXFvyVLN+GJ9wpLiM3zLlGoLp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438467; c=relaxed/simple;
	bh=CMLY035keOpu6fjvgp4q742qgsi3l+0VCoZ7cJkByO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTgmVtWGWELT6Owz9FcaHTAFUvA2eWQgqSYOVp9Z1sYmY3UaeGi6824/3gESqrot8//s2ZUNAwqemtRKTmKDMSEcGg/yQee6Y9QkJiRLBN9ZXF/HkQvxPjq1wGT8SItjnnVTHAgB1gk66GNDC7zhU5Zu5WOoQ8zmEkh7BYA1+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXrHVqtp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b551350adfaso1340846a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759438465; x=1760043265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8aA8eYQbOy4enGJKPbNIIg5fF5qMbQf/5jHtVJ5nvc=;
        b=NXrHVqtpynEKEJtRLn3ibfwDo0wiI74vYMTMCrXilA0Q2GOUn3FEhKArWtalnN7R5t
         WlgLPEFzz0HUvEKdlg9jmd34Z7yOPI5JUMDdduoxfc8KQc1M1zVbi4B5MRM3snlv0d/Q
         viKoZBsftnzUZjL9jbZEiXr4ct7IiIt5cdf7SWZmAF5Uc4TdrAs7ulQgmthFxBRq10X6
         zfXg+yWxw25E61TYruyO+bkkvvadLdDSSC7FTOFT8d9SIzJSDF2cC931iQ4wU0eMsshq
         FdJB07Ga14vEhGV7T4yxpxqekzIC767EE3B3flKxFGNWIiy+GF05ITyjLEMJ5fVxmu+s
         nRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759438465; x=1760043265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8aA8eYQbOy4enGJKPbNIIg5fF5qMbQf/5jHtVJ5nvc=;
        b=we5yO6MC6/ignITE0+2aFSJGsr6/mLIXBcMn/kqx7xYnEn5L/kujF/s/ptCwn+te0a
         PJNoAeu5r6vn5eLpybbR2pSU+/hyUMjrgj+CE1G0zliS2dCYkZn6pZPEl89HI8TsISPo
         wJVCvnBqtSsn0U2GAqYI3mZl4MGBtRDtaqyeUp0KHGtdVeAW4UMXwtYfNynMlQb6/UzF
         2u7yMaGZXuc4dX/2O9923+4r2O27heCBAi23gHlpCVlFZZcfneoaCEtBIi69ZLmWAvqk
         pFhZCkTmBVT4h3X4jqtvFOZRWVIH3/euDqNwABk3Xj/t08GdLq17uJQDUKdiE+gBhhRZ
         jZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCUfnxaCZytZvEkoefYCGuPEIORFzn/wEZOIgGkpK80DTtF+mKpL4/k4mFwMUOJKQXQZmeuvxPn9EmoKHGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnJkKgO0URjR3m/xMKALIOZ6USn208WN63sN+Of84ugOTlikT
	AcqMJ0crOGi8sAoJehMbuo12fm24s41qK0+LkVWsnmeQIYN6hxrwXSaS
X-Gm-Gg: ASbGncvgMshCbXMUwq4U0xPJhZEKn6Kz/g768ysb670jr1d9kEKik3I1p8PpH5U5ZQp
	sYz4HIhdkvhkDdLjzOZoB/e63joEJhEPPFTMsv8dV+vASHlfZeG18vlijfiPtY99NWr4vPPSeCz
	XPbNxUuYjrqEsk19BkyflXV4QyzkaeU+63HIItLQhijXTwFRDXoir9z0pnTIZ9z1ljTWN2MtwX4
	NP2cL32VP/0QBHKsuPL4I01VCNT5Z0dN8vc+crhjD49ga6YMfwI4QHSCAm34nO6iC+5oUhfzyxk
	NaGkU8B+FxIQGBYrMossgvAwFuYjUFNLDj+RjTIsIVkaDGKb4UZ1ZYwzOZJZwqeABZWPgUw3LXA
	kA2xBDdUkZsv6v1IeMt+3vw+RcqmtzPB74HAtIcDUMmihY8s1ESWO18dHbFU=
X-Google-Smtp-Source: AGHT+IGiu9l09JdJ6ZfjgQrIh+h+Pm7NXkpaxqUj8z/G296jIby1wJ/+5YRLY8gYxUFOm0nbWSBUhw==
X-Received: by 2002:a17:903:11ce:b0:269:6052:3536 with SMTP id d9443c01a7336-28e9a67bf21mr7065045ad.45.1759438465299;
        Thu, 02 Oct 2025 13:54:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1108b8sm29533565ad.26.2025.10.02.13.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:54:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 13:54:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: wenswang@yeah.net
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jdelvare@suse.com, corbet@lwn.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: add MP2925 and MP2929 driver
Message-ID: <bd28f637-bae6-4d9e-a94a-019b4104ee09@roeck-us.net>
References: <20250928092655.1394429-1-wenswang@yeah.net>
 <20250928092845.1394718-1-wenswang@yeah.net>
 <20250928092845.1394718-2-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928092845.1394718-2-wenswang@yeah.net>

On Sun, Sep 28, 2025 at 05:28:45PM +0800, wenswang@yeah.net wrote:
> From: Wensheng Wang <wenswang@yeah.net>
> 
> Add support for MPS VR mp2925 and mp2929 controller. This driver exposes
> telemetry and limit value readings and writtings.
> 
> Signed-off-by: Wensheng Wang <wenswang@yeah.net>

Applied to hwmon-next.

Guenter

