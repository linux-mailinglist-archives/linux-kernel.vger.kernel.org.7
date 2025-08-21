Return-Path: <linux-kernel+bounces-780345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF754B300B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953891786E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA5C2FB628;
	Thu, 21 Aug 2025 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0eALz/0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4DE27A108
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795877; cv=none; b=FrjRa4Sm+5asLHWSBdX3LRACzfA6VFnJUS3XarAsJIrUa5mrZaR7VONmIccYbvH0nn1iTBVRJ6GlzuBMWKIPYv3sOrYO4RUB+XyRwhnTFa6Bg2qLxQQsytosKM3dyUJ7v5bhI0XV/1frOClQJrmy+T/GwnXR1iZ7myMM08yI/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795877; c=relaxed/simple;
	bh=HjArpnIMs1ngVxKm1XcLav2e4c4T+poHcOsFHwhCzvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdcZRNOawQP6mYwokPrTVY4Oz6gu0aLLKiv0hKZQOFHTS6gy/pXfuphGUg3kM9MtzXXD8rd/AITgeFO0yvaNYeh+8RJ6luWTR2+beMQAmnQ12He6w1A3C28Pl5cWzN66OT7ZN8dmxhnmWiCAfGkXUfqp7GmBvJ8CRqaqd5unc0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0eALz/0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755795874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ODQrlAYP1AhfYguK1YhrNgiUUW7CUoq0zGFb5LFgh7s=;
	b=e0eALz/0Nk9rjD+syKcdR0mWlRGkCPgVEPcgUEoX9SKWO89CIjx+DGoYtyU+5pzs7pqiWG
	7ZDuKWEAWu/X5po6jYvL/WU2jwLVIN+HdGo+731p+Zl9Ufhly4Gw2IgLILcaqJ31yvNHoA
	P45GO1MGpz9wWHOumfx/2GdSsxX2WiA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-BCqdKg42MhOrlzexu3NoPg-1; Thu,
 21 Aug 2025 13:04:30 -0400
X-MC-Unique: BCqdKg42MhOrlzexu3NoPg-1
X-Mimecast-MFC-AGG-ID: BCqdKg42MhOrlzexu3NoPg_1755795870
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A2F218004D4;
	Thu, 21 Aug 2025 17:04:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.242.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAB5A1800447;
	Thu, 21 Aug 2025 17:04:25 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: safety-architecture@lists.elisa.tech,
	Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [RFC PATCH] /dev/mem: Add initial documentation of memory_open() and mem_fops
Date: Thu, 21 Aug 2025 19:04:19 +0200
Message-ID: <20250821170419.70668-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This patch proposes initial kernel-doc documentation for memory_open()
and most of the functions in the mem_fops structure.
The format used for the **Description** intends to define testable
function's expectations and Assumptions of Use to be met by the
user of the function.

Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
---
I have a couple of comments from this documentation activity:
1) Shouldn't the check in read_mem() <<if (p != *ppos)>> return
   -EFBIG (as done in write_mem())?
2) There is a note in memory_lseek() that states the return value
   to be (0) for negative addresses, however I cannot see how that
   would happen in the current implementation...
---

 drivers/char/mem.c | 209 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 203 insertions(+), 6 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 48839958b0b1..96d59066e8dc 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -75,9 +75,49 @@ static inline bool should_stop_iteration(void)
 	return signal_pending(current);
 }
 
-/*
- * This funcion reads the *physical* memory. The f_pos points directly to the
- * memory location.
+/**
+ * read_mem - read from physical memory (/dev/mem).
+ * @file: file structure for the device.
+ * @buf: user-space buffer to copy data to.
+ * @count: number of bytes to read.
+ * @ppos: pointer to the current file position, representing the physical
+ *        address to read from.
+ *
+ * Function's expectations:
+ *
+ * - This function shall check if the value pointed by ppos exceeds the
+ *   maximum addressable physical address;
+ *
+ * - This function shall check if the physical address range to be read
+ *   is valid (i.e. it falls within a memory block and if it can be mapped
+ *   to the kernel address space);
+ *
+ * - For each memory page falling in the requested physical range
+ *   [ppos, ppos + count - 1]:
+ *   - this function shall check if user space access is allowed;
+ *
+ *   - if access is allowed, the memory content from the page range falling
+ *     within the requested physical range shall be copied to the user space
+ *     buffer;
+ *
+ *   - zeros shall be copied to the user space buffer (for the page range
+ *     falling within the requested physical range):
+ *     - if access to the memory page is restricted or,
+ *     - if the current page is page 0 on HW architectures where page 0 is not
+ *       mapped.
+ *
+ * - The file position '*ppos' shall be advanced by the number of bytes
+ *   successfully copied to user space (including zeros).
+ *
+ * Context: process context.
+ *
+ * Return:
+ * * the number of bytes copied to user on success
+ * * %-EFAULT - the requested address range is not valid or a fault happened
+ *   when copying to user
+ * * %-EPERM - access to any of the required pages is not allowed
+ * * %-ENOMEM - out of memory error for auxiliary kernel buffers supporting
+ *   the operation of copying content from the physical pages
  */
 static ssize_t read_mem(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
@@ -166,6 +206,48 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 	return err;
 }
 
+/**
+ * write_mem - write to physical memory (/dev/mem).
+ * @file: file structure for the device.
+ * @buf: user-space buffer containing the data to write.
+ * @count: number of bytes to write.
+ * @ppos: pointer to the current file position, representing the physical
+ *        address to write to.
+ *
+ * Function's expectations:
+ * - This function shall check if the value pointed by ppos exceeds the
+ *   maximum addressable physical address;
+ *
+ * - This function shall check if the physical address range to be written
+ *   is valid (i.e. it falls within a memory block and if it can be mapped
+ *   to the kernel address space);
+ *
+ * - For each memory page falling in the physical range to be written
+ *   [ppos, ppos + count - 1]:
+ *   - this function shall check if user space access is allowed;
+ *
+ *   - the content from the user space buffer shall be copied to the page range
+ *     falling within the physical range to be written if access is allowed;
+ *
+ *   - the data to be copied from the user space buffer (for the page range
+ *     falling within the range to be written) shall be skipped:
+ *     - if access to the memory page is restricted or,
+ *     - if the current page is page 0 on HW architectures where page 0 is not
+ *       mapped.
+ *
+ * - The file position '*ppos' shall be advanced by the number of bytes
+ *   successfully copied from user space (including skipped bytes).
+ *
+ * Context: process context.
+ *
+ * Return:
+ * * the number of bytes copied to user on success
+ * * %-EFBIG - the value pointed by ppos exceeds the maximum addressable
+ *   physical address
+ * * %-EFAULT - the physical address range is not valid or a fault happened
+ *   when copying from user
+ * * %-EPERM - access to any of the required pages is not allowed
+ */
 static ssize_t write_mem(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
@@ -322,6 +404,37 @@ static const struct vm_operations_struct mmap_mem_ops = {
 #endif
 };
 
+/**
+ * mmap_mem - map physical memory into user space (/dev/mem).
+ * @file: file structure for the device.
+ * @vma: virtual memory area structure describing the user mapping.
+ *
+ * Function's expectations:
+ * - This function shall check if the requested physical address range to be
+ *   mapped fits within the maximum addressable physical range;
+ *
+ * - This function shall check if the requested  physical range corresponds to
+ *   a valid physical range and if access is allowed on it;
+ *
+ * - This function shall check if the input virtual memory area can be used for
+ *   a private mapping (always OK if there is an MMU);
+ *
+ * - This function shall set the virtual memory area operations to
+ *   &mmap_mem_ops;
+ *
+ * - This function shall establish a mapping between the user-space
+ *   virtual memory area described by vma and the physical memory
+ *   range specified by vma->vm_pgoff and size;
+ *
+ * Context: process context.
+ *
+ * Return:
+ * * 0 on success
+ * * %-EAGAIN - invalid or unsupported mapping requested (remap_pfn_range()
+ *   fails)
+ * * %-EINVAL - requested physical range to be mapped is not valid
+ * * %-EPERM - no permission to access the requested physical range
+ */
 static int mmap_mem(struct file *file, struct vm_area_struct *vma)
 {
 	size_t size = vma->vm_end - vma->vm_start;
@@ -550,13 +663,44 @@ static loff_t null_lseek(struct file *file, loff_t offset, int orig)
 	return file->f_pos = 0;
 }
 
-/*
+/**
+ * memory_lseek - change the file position.
+ * @file: file structure for the device.
+ * @offset: file offset to seek to.
+ * @orig: where to start seeking from (see whence in the llseek manpage).
+ *
+ * Function's expectations:
+ * - This function shall lock the semaphore of the inode corresponding to the
+ *   input file before any operation and unlock it before returning.
+ *
+ * - This function shall check the orig value and accordingly:
+ *   - if it is equal to SEEK_CUR, the current file position shall be
+ *     incremented by the input offset;
+ *   - if it is equal to SEEK_SET, the current file position shall be
+ *     set to the input offset value;
+ *   - any other value shall result in an error condition.
+ *
+ * - Before writing the current file position, the new position value
+ *   shall be checked to not overlap with Linux ERRNO values.
+ *
+ * Assumptions of Use:
+ * - the input file pointer is expected to be valid.
+ *
+ * Notes:
  * The memory devices use the full 32/64 bits of the offset, and so we cannot
  * check against negative addresses: they are ok. The return value is weird,
  * though, in that case (0).
  *
- * also note that seeking relative to the "end of file" isn't supported:
- * it has no meaning, so it returns -EINVAL.
+ * Also note that seeking relative to the "end of file" isn't supported:
+ * it has no meaning, so passing orig equal to SEEK_END returns -EINVAL.
+ *
+ * Context: process context, locks/unlocks inode->i_rwsem
+ *
+ * Return:
+ * * the new file position on success
+ * * %-EOVERFLOW - the new position value equals or exceeds
+ *   (unsigned long long) -MAX_ERRNO
+ * * %-EINVAL - the orig parameter is invalid
  */
 static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 {
@@ -584,6 +728,32 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 	return ret;
 }
 
+/**
+ * open_port - open the I/O port device (/dev/port).
+ * @inode: inode of the device file.
+ * @filp: file structure for the device.
+ *
+ * Function's expectations:
+ * - This function shall check if the caller has sufficient capabilities to
+ *   perform raw I/O access;
+ *
+ * - This function shall check if the kernel is locked down with the
+ *   &LOCKDOWN_DEV_MEM restriction;
+ *
+ * - If the input inode corresponds to /dev/mem, the f_mapping pointer
+ *   of the input file structure shall be set to the i_mapping pointer
+ *   of the input inode;
+ *
+ * Assumptions of Use:
+ * - The input inode and filp are expected to be valid.
+ *
+ * Context: process context.
+ *
+ * Return:
+ * * 0 on success
+ * * %-EPERM - caller lacks the required capability (CAP_SYS_RAWIO)
+ * * any error returned by securty_locked_down()
+ */
 static int open_port(struct inode *inode, struct file *filp)
 {
 	int rc;
@@ -691,6 +861,33 @@ static const struct memdev {
 #endif
 };
 
+/**
+ * memory_open - set the filp f_op to the memory device fops and invoke open().
+ * @inode: inode of the device file.
+ * @filp: file structure for the device.
+ *
+ * Function's expectations:
+ * - This function shall retrieve the minor number associated with the input
+ *   inode and the memory device corresponding to such minor number;
+ *
+ * - The file operations pointer shall be set to the memory device file operations;
+ *
+ * - The file mode member of the input filp shall be OR'd with the device mode;
+ *
+ * - The memory device open() file operation shall be invoked.
+ *
+ * Assumptions of Use:
+ * - The input inode and filp are expected to be non-NULL.
+ *
+ * Context: process context.
+ *
+ * Return:
+ * * 0 on success
+ * * %-ENXIO - the minor number corresponding to the input inode cannot be
+ *   associated with any device or the corresponding device has a NULL fops
+ *   pointer
+ * * any error returned by the device specific open function pointer
+ */
 static int memory_open(struct inode *inode, struct file *filp)
 {
 	int minor;
-- 
2.48.1


