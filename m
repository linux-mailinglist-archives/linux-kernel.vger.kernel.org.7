Return-Path: <linux-kernel+bounces-883475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B232C2D8B4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B2AA4ED854
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A731D378;
	Mon,  3 Nov 2025 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugVLZ9ut"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A15B31C596;
	Mon,  3 Nov 2025 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192420; cv=none; b=lWc0Eql8B+WNoZLUosQHKFXr+PMB+aOyUluc6c6SXTkTMWqXI+fGQ9gdN+rQCzqCG0CBhUbhGnYuNx6ooCxCfhPGdXbFcvkO7bMvL6MyMv8r0tvuZ6LOnPiBBDMIquJF8K1ar1Fu9SyZap1D2npkK3v1hUwaMLvyCZS4SLZxiAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192420; c=relaxed/simple;
	bh=B6HA5JHab285szoGPrmV08KkVodoiomSuzjYOmmg2Mo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kDxDVWYIYS3Ax435n7i8StAdEg9ZGcPXn5l538/UTcpqLhO28i5aicZr6pOqEtX+dpjUafdYnej75dKlzsCBv5fIwPu+CDZEBw1mh1+6hrisLEyJ4j67umyYgRb5AvpSisnS+3n33kTtvxbOrs18vOBPcMztXeRHtKF//9Tdyqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugVLZ9ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0960DC4CEF8;
	Mon,  3 Nov 2025 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192419;
	bh=B6HA5JHab285szoGPrmV08KkVodoiomSuzjYOmmg2Mo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ugVLZ9utCYOROBrZEzTkhyAyTOygjfo8Sa2xIhf848IWfpjrk5UOET2nK0qwmqs7P
	 39Cxq1uIgAeZCmJ1OtkK+IFfno42aR6BTKGourrGdxTVF9aOB/zMFR4+os/AtaA0aY
	 qOkq+h77cqq1YzVY58nJhY9iptMOuR79nS3Cdn01DtYyz6X22nw2tnq8HQEckA4WZo
	 4QhDyp7eDEx8ROHkROAn1IEXjk+V6WnyUFf5SdZ+BohqY5qBlR/ptJzg0AcF/52fAm
	 R9Y6io3erKHvhN4l6l6Xh09YCDLUUjHmAlVaRzNV2/NHw0DnkgM3zmHnZ4H0BHlLtF
	 5XTkcjUPbDLZQ==
From: Namhyung Kim <namhyung@kernel.org>
To: john.g.garry@oracle.com, will@kernel.org, james.clark@linaro.org, 
 mike.leach@linaro.org, leo.yan@linux.dev, peterz@infradead.org, 
 mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, Chu Guangqing <chuguangqing@inspur.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251031025810.1939-1-chuguangqing@inspur.com>
References: <20251031025810.1939-1-chuguangqing@inspur.com>
Subject: Re: [PATCH] tools/perf: Fix spelling typo in tools/perf
Message-Id: <176219241792.1981113.11259694357369931202.b4-ty@kernel.org>
Date: Mon, 03 Nov 2025 09:53:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 31 Oct 2025 10:58:10 +0800, Chu Guangqing wrote:
> The json file incorrectly used "acceses" instead of "accesses".
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



